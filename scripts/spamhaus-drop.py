#!/usr/bin/python3
"""Maintain WAN-only Spamhaus DROP sets independently of VyOS's own tables."""

import argparse
import fcntl
import ipaddress
import json
import os
from pathlib import Path
import subprocess
import sys
import syslog
import tempfile
import time
import urllib.request


CACHE = Path('/config/user-data/spamhaus-drop/cache.json')
LOCK = '/run/lock/spamhaus-drop.lock'
NFT = '/usr/sbin/nft'
FEEDS = {
    4: 'https://www.spamhaus.org/drop/drop_v4.json',
    6: 'https://www.spamhaus.org/drop/drop_v6.json',
}
MAX_BYTES = 4 * 1024 * 1024
MAX_AGE = 7 * 86400


def report(message, error=False):
    print(message, file=sys.stderr if error else sys.stdout)
    syslog.syslog(syslog.LOG_ERR if error else syslog.LOG_INFO, message)


def prefixes(records, version, fresh=False):
    """Reject partial, empty, stale or unsafe feeds before touching the firewall."""
    if not isinstance(records, list) or len(records) < 2:
        raise ValueError(f'IPv{version}: empty feed')
    metadata = records[-1]
    if (not isinstance(metadata, dict) or metadata.get('type') != 'metadata'
            or metadata.get('records') != len(records) - 1):
        raise ValueError(f'IPv{version}: missing metadata or record count mismatch')
    timestamp = metadata.get('timestamp')
    if not isinstance(timestamp, int):
        raise ValueError(f'IPv{version}: missing feed timestamp')
    if fresh and not -86400 <= time.time() - timestamp <= MAX_AGE:
        raise ValueError(f'IPv{version}: stale or future-dated feed')
    if not metadata.get('copyright'):
        raise ValueError(f'IPv{version}: missing Spamhaus attribution')

    networks = []
    for record in records[:-1]:
        if not isinstance(record, dict) or not isinstance(record.get('cidr'), str):
            raise ValueError(f'IPv{version}: invalid network record')
        network = ipaddress.ip_network(record['cidr'], strict=True)
        if (network.version != version or not network.is_global
                or network.is_multicast
                or network.prefixlen < (8 if version == 4 else 19)
                or (version == 6 and not network.subnet_of(
                    ipaddress.ip_network('2000::/3')))):
            raise ValueError(f'IPv{version}: unsafe prefix {network}')
        networks.append(network)
    return list(ipaddress.collapse_addresses(networks))


def download(version):
    request = urllib.request.Request(
        FEEDS[version], headers={'User-Agent': 'vyos-spamhaus-drop/1.0'})
    with urllib.request.urlopen(request, timeout=30) as response:
        if response.status != 200 or not response.url.startswith('https://'):
            raise ValueError(f'IPv{version}: unexpected HTTP response')
        data = response.read(MAX_BYTES + 1)
    if len(data) > MAX_BYTES:
        raise ValueError(f'IPv{version}: feed exceeds size limit')
    records = [json.loads(line) for line in data.decode('utf-8').splitlines()
               if line.strip()]
    prefixes(records, version, fresh=True)
    return records


def ruleset(networks):
    v4 = ', '.join(str(network) for network in networks[4])
    v6 = ', '.join(str(network) for network in networks[6])
    # add/delete/recreate is one atomic nft transaction, whether or not the
    # table exists. Never flush the ruleset or modify VyOS-owned tables.
    return f'''add table inet spamhaus_drop
delete table inet spamhaus_drop
table inet spamhaus_drop {{
    set drop_v4 {{
        type ipv4_addr; flags interval; auto-merge;
        elements = {{ {v4} }}
    }}
    set drop_v6 {{
        type ipv6_addr; flags interval; auto-merge;
        elements = {{ {v6} }}
    }}
    chain wan_ingress {{
        type filter hook prerouting priority -310; policy accept;
        iifname "eth3" ip saddr @drop_v4 counter drop
        iifname "eth3" ip6 saddr @drop_v6 counter drop
    }}
    chain wan_egress {{
        type filter hook postrouting priority -150; policy accept;
        oifname "eth3" ip daddr @drop_v4 counter drop
        oifname "eth3" ip6 daddr @drop_v6 counter drop
    }}
}}
'''


def install(cache):
    networks = {version: prefixes(cache[f'ipv{version}'], version)
                for version in FEEDS}
    subprocess.run([NFT, '-f', '-'], input=ruleset(networks), text=True,
                   check=True, capture_output=True, timeout=30)
    report('Installed Spamhaus DROP: '
           + ', '.join(f'{len(items)} IPv{version} prefixes'
                       for version, items in networks.items()))


def update():
    # Rate-limit failed attempts too: one family may have downloaded before
    # the other failed. Boot/commit restores never fetch anything.
    attempt = CACHE.with_name('last-attempt')
    previous = json.loads(CACHE.read_text()) if CACHE.exists() else None
    recent = max(attempt.stat().st_mtime if attempt.exists() else 0,
                 previous.get('fetched_at', 0) if previous else 0)
    if time.time() - recent < 3600:
        if previous is None:
            raise ValueError('No cache yet; wait an hour after the last fetch attempt')
        install(previous)
        report('Using the cache: last fetch attempt was under an hour ago')
        return
    CACHE.parent.mkdir(parents=True, exist_ok=True)
    attempt.touch()
    cache = {f'ipv{version}': download(version) for version in FEEDS}
    cache['fetched_at'] = int(time.time())
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(
                mode='w', dir=CACHE.parent, delete=False) as output:
            temporary = Path(output.name)
            json.dump(cache, output)
            output.flush()
            os.fsync(output.fileno())
        # Both families must validate and install before publishing the cache.
        install(cache)
        os.replace(temporary, CACHE)
    finally:
        if temporary is not None and temporary.exists():
            temporary.unlink()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--update', action='store_true', help='Fetch and install both feeds')
    mode.add_argument('--restore', action='store_true', help='Restore the cache without fetching')
    args = parser.parse_args()
    syslog.openlog('spamhaus-drop')
    try:
        with open(LOCK, 'a') as lock:
            try:
                fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
            except BlockingIOError:
                report('Another Spamhaus DROP operation is running')
                return 0
            if args.update:
                update()
            elif CACHE.exists():
                cache = json.loads(CACHE.read_text())
                install(cache)
                if time.time() - cache.get('fetched_at', 0) > MAX_AGE:
                    report('Restored cache is over seven days old; check the updater', error=True)
            else:
                report('No Spamhaus DROP cache yet; run --update to enable blocking', error=True)
                return 1
    except (OSError, ValueError, KeyError, TypeError, subprocess.SubprocessError) as error:
        detail = error.stderr if isinstance(error, subprocess.CalledProcessError) else str(error)
        report(f'Spamhaus DROP failed: {detail}', error=True)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
