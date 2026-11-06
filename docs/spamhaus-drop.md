# Spamhaus DROP filtering

The gateway blocks traffic arriving on WAN `eth3` from Spamhaus DROP prefixes,
and traffic leaving `eth3` for those prefixes. Both IPv4 and IPv6 are covered,
including forwarded traffic, the router's own traffic and established sessions.
Internal traffic is unaffected unless it leaves through the WAN. ASN-DROP is
not used.

`scripts/spamhaus-drop.py` downloads the official, newline-delimited JSON feeds:

- https://www.spamhaus.org/drop/drop_v4.json
- https://www.spamhaus.org/drop/drop_v6.json

The feeds are copyright The Spamhaus Project. Original feed records, timestamps
and attribution are retained in `/config/user-data/spamhaus-drop/cache.json`.
See the [Spamhaus DROP policy](https://www.spamhaus.org/blocklists/do-not-route-or-peer/).

## Installation and updates

Install the executable updater and commit hook under `/config/scripts`, along
with the updated boot hook. Run the first update before applying
`config-parts/spamhaus-drop.sh`:

```sh
sudo /config/scripts/spamhaus-drop.py --update
```

The VyOS task scheduler updates both feeds daily at 04:17 local time. Manual
updates within an hour of a fetch attempt reuse the cache, including after a
failed update. Downloads are
bounded and validated for record count, timestamp, address family and public
prefixes. Empty, truncated, stale, malformed or overly broad feeds are rejected.
Both families are replaced in one nftables transaction only after validation.
An update failure leaves the existing firewall and persistent cache intact.

Boot and commit hooks restore the cache without network access. An old cache is
still restored, with a warning after seven days, rather than silently disabling
blocking. A fresh install without a cache needs the initial update above.

## Firewall ownership

VyOS 1.4 on this gateway lacks native URL-backed `remote-group` support. The
updater therefore owns only the `inet spamhaus_drop` nftables table. It never
flushes the full ruleset or modifies VyOS's generated tables.

Ingress filtering runs in prerouting at priority -310, before connection tracking
and destination NAT. Egress filtering runs in postrouting at priority -150,
after routing and before source NAT. These hooks cover all WAN traffic and are
independent of the zone policies' established/related accepts. They only drop;
other traffic continues through the normal VyOS firewall.

Inspect rule counters and update messages with:

```sh
sudo nft list chain inet spamhaus_drop wan_ingress
sudo nft list chain inet spamhaus_drop wan_egress
journalctl -t spamhaus-drop
```

Counters reset when the table is restored or updated. Individual dropped packets
are not logged. Restore a missing table without downloading with:

```sh
sudo /config/scripts/spamhaus-drop.py --restore
```

To disable filtering, remove the scheduler task and both hook invocations, then
delete the table (`sudo nft delete table inet spamhaus_drop`). Otherwise a hook
will reinstall it. Keep the cache if it may be re-enabled later.

When upgrading VyOS, reconsider moving feed ownership to native remote groups.
The policy must still cover both WAN directions and established connections.
