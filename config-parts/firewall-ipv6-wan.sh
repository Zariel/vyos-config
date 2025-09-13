#!/bin/vbash

# WAN to LOCAL
set firewall ipv6 name wan-local default-action 'drop'
set firewall ipv6 name wan-local default-log
set firewall ipv6 name wan-local rule 30 description 'Rule: allow_dhcpv6'
set firewall ipv6 name wan-local rule 30 action 'accept'
set firewall ipv6 name wan-local rule 30 destination port '546'
set firewall ipv6 name wan-local rule 30 protocol 'udp'
set firewall ipv6 name wan-local rule 30 source port '547'

# WAN to TRUSTED
set firewall ipv6 name wan-trusted rule 100 description 'Rule: allow_roon_arc'
set firewall ipv6 name wan-trusted rule 100 destination group port-group 'roon_arc_ports'
set firewall ipv6 name wan-trusted rule 100 destination address-mask ::7c7d:c6ff:fec7:26ac
set firewall ipv6 name wan-trusted rule 100 protocol 'tcp'
set firewall ipv6 name wan-trusted rule 100 action 'accept'

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
