#!/bin/vbash

# WAN to LOCAL
set firewall ipv6 name wan-local default-action 'drop'
# Neighbor discovery must originate on the WAN link. Only router adverts need
# a link-local source; solicitations may use :: for duplicate-address detection.
set firewall ipv6 name wan-local rule 24 action accept
set firewall ipv6 name wan-local rule 24 protocol icmpv6
set firewall ipv6 name wan-local rule 24 icmpv6 type-name nd-router-advert
set firewall ipv6 name wan-local rule 24 source address 'fe80::/10'
set firewall ipv6 name wan-local rule 24 hop-limit eq '255'
set firewall ipv6 name wan-local rule 25 action accept
set firewall ipv6 name wan-local rule 25 protocol icmpv6
set firewall ipv6 name wan-local rule 25 icmpv6 type-name nd-router-solicit
set firewall ipv6 name wan-local rule 25 hop-limit eq '255'
set firewall ipv6 name wan-local rule 26 action accept
set firewall ipv6 name wan-local rule 26 protocol icmpv6
set firewall ipv6 name wan-local rule 26 icmpv6 type-name nd-neighbor-solicit
set firewall ipv6 name wan-local rule 26 hop-limit eq '255'
set firewall ipv6 name wan-local rule 27 action accept
set firewall ipv6 name wan-local rule 27 protocol icmpv6
set firewall ipv6 name wan-local rule 27 icmpv6 type-name nd-neighbor-advert
set firewall ipv6 name wan-local rule 27 hop-limit eq '255'
set firewall ipv6 name wan-local rule 28 action 'accept'
set firewall ipv6 name wan-local rule 28 description 'WAN multicast membership queries'
set firewall ipv6 name wan-local rule 28 protocol 'icmpv6'
set firewall ipv6 name wan-local rule 28 icmpv6 type-name 'mld-listener-query'
set firewall ipv6 name wan-local rule 28 source address 'fe80::/10'
set firewall ipv6 name wan-local rule 28 destination address 'ff02::/16'
set firewall ipv6 name wan-local rule 28 hop-limit eq '1'
set firewall ipv6 name wan-local rule 30 description 'Rule: allow_dhcpv6'
set firewall ipv6 name wan-local rule 30 action 'accept'
set firewall ipv6 name wan-local rule 30 destination port '546'
set firewall ipv6 name wan-local rule 30 protocol 'udp'
set firewall ipv6 name wan-local rule 30 source port '547'

# WAN to IOT
set firewall ipv6 name wan-iot rule 100 description 'Rule: allow_xbox_live'
set firewall ipv6 name wan-iot rule 100 destination port 3074
set firewall ipv6 name wan-iot rule 100 destination address-mask ::5679:68e4:9fe0:46e4
set firewall ipv6 name wan-iot rule 100 protocol 'tcp_udp'
set firewall ipv6 name wan-iot rule 100 action 'accept'
set firewall ipv6 name wan-iot rule 101 description 'Rule: allow_xbox_live_udp'
set firewall ipv6 name wan-iot rule 101 destination port 88,500,3544,4500
set firewall ipv6 name wan-iot rule 101 destination address-mask ::5679:68e4:9fe0:46e4
set firewall ipv6 name wan-iot rule 101 protocol 'udp'
set firewall ipv6 name wan-iot rule 101 action 'accept'
