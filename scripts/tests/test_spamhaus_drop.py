"""Feed validation and failure recovery; no network or root access required."""

import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import time
import unittest
from unittest.mock import patch


spec = importlib.util.spec_from_file_location(
    'spamhaus_drop', Path(__file__).resolve().parents[1] / 'spamhaus-drop.py')
drop = importlib.util.module_from_spec(spec)
spec.loader.exec_module(drop)


def feed(cidr, timestamp=None):
    return [{'cidr': cidr, 'sblid': 'SBL-test'}, {
        'type': 'metadata', 'records': 1,
        'timestamp': int(time.time()) if timestamp is None else timestamp,
        'copyright': '(c) The Spamhaus Project',
    }]


class ValidationTests(unittest.TestCase):
    def test_official_ndjson_metadata_and_overlapping_prefixes(self):
        records = feed('8.8.8.0/24')
        records.insert(1, {'cidr': '8.8.8.128/25'})
        records[-1]['records'] = 2
        self.assertEqual([str(net) for net in drop.prefixes(records, 4)],
                         ['8.8.8.0/24'])

    def test_invalid_feeds_rejected(self):
        bad_count = feed('8.8.8.0/24')
        bad_count[-1]['records'] = 2
        for records, version in [
            ([], 4), (feed('8.8.8.0/24')[:-1], 4), (bad_count, 4),
            (feed('0.0.0.0/0'), 4), (feed('10.0.0.0/8'), 4),
            (feed('127.0.0.1/32'), 4), (feed('224.0.0.0/4'), 4),
            (feed('8.8.8.1/24'), 4), (feed('2001:4860::/32'), 4),
            (feed('::/0'), 6), (feed('fe80::/64'), 6),
            (feed('fd74:f571:d3bd::/48'), 6),
            (feed('8.8.8.0/24; flush ruleset'), 4),
        ]:
            with self.subTest(records=records, version=version):
                with self.assertRaises(ValueError):
                    drop.prefixes(records, version)

    def test_stale_cache_restores_but_stale_download_rejected(self):
        records = feed('2001:4860::/32', int(time.time()) - 8 * 86400)
        self.assertEqual(len(drop.prefixes(records, 6)), 1)
        with self.assertRaises(ValueError):
            drop.prefixes(records, 6, fresh=True)
        with self.assertRaises(ValueError):
            drop.prefixes(feed('8.8.8.0/24', int(time.time()) + 2 * 86400),
                          4, fresh=True)


class UpdateTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.cache_path = Path(self.directory.name) / 'cache.json'
        self.cache = {'ipv4': feed('8.8.8.0/24'),
                      'ipv6': feed('2001:4860::/32'),
                      'fetched_at': int(time.time()) - 2 * 86400}
        self.original = json.dumps(self.cache)
        self.cache_path.write_text(self.original)
        self.cache_patch = patch.object(drop, 'CACHE', self.cache_path)
        self.cache_patch.start()
        self.addCleanup(self.cache_patch.stop)

    def test_second_feed_failure_does_not_change_firewall_or_cache(self):
        with patch.object(drop, 'download', side_effect=[
                feed('9.9.9.0/24'), OSError('feed unavailable')]), \
                patch.object(drop.subprocess, 'run') as nft:
            with self.assertRaises(OSError):
                drop.update()
        nft.assert_not_called()
        self.assertEqual(self.cache_path.read_text(), self.original)
        with patch.object(drop, 'download') as download, \
                patch.object(drop, 'install') as install:
            drop.update()
        download.assert_not_called()
        install.assert_called_once_with(self.cache)

    def test_nft_failure_preserves_previous_cache(self):
        with patch.object(drop, 'download', side_effect=[
                feed('9.9.9.0/24'), feed('2606:4700::/32')]), \
                patch.object(drop.subprocess, 'run', side_effect=
                             subprocess.CalledProcessError(1, ['nft'])):
            with self.assertRaises(subprocess.CalledProcessError):
                drop.update()
        self.assertEqual(self.cache_path.read_text(), self.original)
        self.assertEqual({item.name for item in self.cache_path.parent.iterdir()},
                         {'cache.json', 'last-attempt'})

    def test_both_families_installed_in_single_transaction_before_cache_replaced(self):
        def nft_run(command, **kwargs):
            self.assertEqual(self.cache_path.read_text(), self.original)
            self.assertEqual(command, [drop.NFT, '-f', '-'])
            self.assertIn('9.9.9.0/24', kwargs['input'])
            self.assertIn('2606:4700::/32', kwargs['input'])
            return subprocess.CompletedProcess(command, 0)

        with patch.object(drop, 'download', side_effect=[
                feed('9.9.9.0/24'), feed('2606:4700::/32')]), \
                patch.object(drop.subprocess, 'run', side_effect=nft_run) as nft:
            drop.update()
        self.assertEqual(nft.call_count, 1)
        self.assertEqual(json.loads(self.cache_path.read_text())['ipv4'][0]['cidr'],
                         '9.9.9.0/24')

    def test_recent_cache_avoids_extra_downloads(self):
        self.cache['fetched_at'] = int(time.time())
        self.cache_path.write_text(json.dumps(self.cache))
        with patch.object(drop, 'download') as download, \
                patch.object(drop, 'install') as install:
            drop.update()
        download.assert_not_called()
        install.assert_called_once_with(self.cache)


if __name__ == '__main__':
    unittest.main()
