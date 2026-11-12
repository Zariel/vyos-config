#!/bin/vbash

# From LOCAL to WAN
set firewall ipv6 name local-wan default-action 'drop'
set firewall ipv6 name local-wan default-log

# DHCPv6-PD uses multicast discovery and may renew against a unicast server.
set firewall ipv6 name local-wan rule 10 action 'accept'
set firewall ipv6 name local-wan rule 10 description 'WAN DHCPv6 client'
set firewall ipv6 name local-wan rule 10 protocol 'udp'
set firewall ipv6 name local-wan rule 10 source port '546'
set firewall ipv6 name local-wan rule 10 destination port '547'

set firewall ipv6 name local-wan rule 11 action 'accept'
set firewall ipv6 name local-wan rule 11 description 'Discover WAN routers'
set firewall ipv6 name local-wan rule 11 protocol 'icmpv6'
set firewall ipv6 name local-wan rule 11 icmpv6 type-name 'nd-router-solicit'
set firewall ipv6 name local-wan rule 11 destination address 'ff02::2'
set firewall ipv6 name local-wan rule 11 hop-limit eq '255'

# Neighbor discovery includes multicast, unicast probes and DAD.
icmp_rule=12
for icmp_type in nd-neighbor-solicit nd-neighbor-advert; do
    set firewall ipv6 name local-wan rule "$icmp_rule" action 'accept'
    set firewall ipv6 name local-wan rule "$icmp_rule" description "WAN $icmp_type"
    set firewall ipv6 name local-wan rule "$icmp_rule" protocol 'icmpv6'
    set firewall ipv6 name local-wan rule "$icmp_rule" icmpv6 type-name "$icmp_type"
    set firewall ipv6 name local-wan rule "$icmp_rule" hop-limit eq '255'
    icmp_rule=$((icmp_rule + 1))
done

# Report WAN multicast memberships to the provider's switches/querier.
for icmp_type in mld-listener-report mld-listener-reduction mld2-listener-report; do
    set firewall ipv6 name local-wan rule "$icmp_rule" action 'accept'
    set firewall ipv6 name local-wan rule "$icmp_rule" description "WAN $icmp_type"
    set firewall ipv6 name local-wan rule "$icmp_rule" protocol 'icmpv6'
    set firewall ipv6 name local-wan rule "$icmp_rule" icmpv6 type-name "$icmp_type"
    set firewall ipv6 name local-wan rule "$icmp_rule" destination address 'ff02::/16'
    set firewall ipv6 name local-wan rule "$icmp_rule" hop-limit eq '1'
    icmp_rule=$((icmp_rule + 1))
done
unset icmp_rule icmp_type

set firewall ipv6 name local-wan rule 20 action 'drop'
set firewall ipv6 name local-wan rule 20 description 'Block other WAN multicast'
set firewall ipv6 name local-wan rule 20 destination address 'ff00::/8'

set firewall ipv6 name local-wan rule 30 action 'accept'
set firewall ipv6 name local-wan rule 30 description 'DNS to configured resolver'
set firewall ipv6 name local-wan rule 30 protocol 'tcp_udp'
set firewall ipv6 name local-wan rule 30 destination address '2606:4700:4700::1111'
set firewall ipv6 name local-wan rule 30 destination port '53'

set firewall ipv6 name local-wan rule 40 action 'accept'
set firewall ipv6 name local-wan rule 40 description 'NTP client'
set firewall ipv6 name local-wan rule 40 protocol 'udp'
set firewall ipv6 name local-wan rule 40 destination port '123'
set firewall ipv6 name local-wan rule 50 action 'accept'
set firewall ipv6 name local-wan rule 50 description 'HTTPS maintenance and DDNS'
set firewall ipv6 name local-wan rule 50 protocol 'tcp'
set firewall ipv6 name local-wan rule 50 destination port '443'

set firewall ipv6 name local-wan rule 60 action 'accept'
set firewall ipv6 name local-wan rule 60 description 'WireGuard router socket'
set firewall ipv6 name local-wan rule 60 protocol 'udp'
set firewall ipv6 name local-wan rule 60 source port '51820'

icmp_rule=70
for icmp_type in echo-request echo-reply destination-unreachable packet-too-big time-exceeded parameter-problem; do
    set firewall ipv6 name local-wan rule "$icmp_rule" action 'accept'
    set firewall ipv6 name local-wan rule "$icmp_rule" description "ICMPv6 $icmp_type"
    set firewall ipv6 name local-wan rule "$icmp_rule" protocol 'icmpv6'
    set firewall ipv6 name local-wan rule "$icmp_rule" icmpv6 type-name "$icmp_type"
    icmp_rule=$((icmp_rule + 1))
done
unset icmp_rule icmp_type

# From LOCAL to TRUSTED
set firewall ipv6 name local-trusted rule 30 description 'Rule: allow_dhcpv6'
set firewall ipv6 name local-trusted rule 30 action 'accept'
set firewall ipv6 name local-trusted rule 30 destination port '546'
set firewall ipv6 name local-trusted rule 30 protocol 'udp'
set firewall ipv6 name local-trusted rule 30 source port '547'
set firewall ipv6 name local-trusted rule 110 action 'accept'
set firewall ipv6 name local-trusted rule 110 description 'Rule: accept_mdns'
set firewall ipv6 name local-trusted rule 110 destination port 'mdns'
set firewall ipv6 name local-trusted rule 110 destination address 'ff02::fb'
set firewall ipv6 name local-trusted rule 110 protocol 'udp'

# From LOCAL to IOT
set firewall ipv6 name local-iot rule 110 action 'accept'
set firewall ipv6 name local-iot rule 110 description 'Rule: accept_mdns'
set firewall ipv6 name local-iot rule 110 destination port 'mdns'
set firewall ipv6 name local-iot rule 110 destination address 'ff02::fb'
set firewall ipv6 name local-iot rule 110 protocol 'udp'
