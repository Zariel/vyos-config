# nftables Zone Firewall (IPv4 parity pass)

This directory migrates the VyOS zone firewall to nftables with a parity-first model.

## Files
- `ruleset.nft`: entrypoint used by NixOS.
- `sets.nft`: reusable address/network/port sets.
- `zone-directions.nft`: base hooks and zone dispatch by interface direction.
- `zone-rules.nft`: `FROM-TO` chains with allow rules and terminal actions.

## NixOS wiring

```nix
{
  networking.nftables.enable = true;
  networking.nftables.rulesetFile = /etc/nftables/ruleset.nft;
}
```

Deploy all files in this directory to `/etc/nftables/` on the router so include paths resolve.

## Validation

```bash
nft -c -f /etc/nftables/ruleset.nft
```

## Editing model
1. Add/update reusable groups in `sets.nft`.
2. Adjust interface-to-zone mapping in `zone-directions.nft` if interface names change.
3. Edit policy in the specific chain in `zone-rules.nft` (example: `IOT-LOCAL`).

For pure deny paths, the dispatcher logs and drops directly in `zone-directions.nft`.
