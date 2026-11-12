#!/bin/vbash

# Avahi's legacy reflector sends queries from an ephemeral port. Replies from
# UDP 5353 return to that port, then Avahi sends them to the original client's
# ephemeral port. Multicast conntrack entries do not cover these unicast legs.
# Keep these allowances on reflector LANs and above the privileged port range;
# this also permits ordinary unicast mDNS replies to client port 5353.
for mdns_family in ipv4 ipv6; do
    for mdns_zone in trusted iot thread matter; do
        if [[ "$mdns_family" == ipv4 && ( "$mdns_zone" == thread || "$mdns_zone" == matter ) ]]; then
            continue
        fi
        for mdns_policy in "$mdns_zone-local" "local-$mdns_zone"; do
            set firewall "$mdns_family" name "$mdns_policy" rule 112 action 'accept'
            set firewall "$mdns_family" name "$mdns_policy" rule 112 description 'Avahi unicast mDNS replies'
            set firewall "$mdns_family" name "$mdns_policy" rule 112 protocol 'udp'
            set firewall "$mdns_family" name "$mdns_policy" rule 112 source port '5353'
            set firewall "$mdns_family" name "$mdns_policy" rule 112 destination port '1024-65535'
        done
    done
done
unset mdns_family mdns_zone mdns_policy
