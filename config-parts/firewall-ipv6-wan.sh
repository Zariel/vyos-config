#!/bin/vbash

# WAN to LOCAL
set firewall ipv6 name wan-local default-action 'drop'
set firewall ipv6 name wan-local default-log
set firewall ipv6 name wan-local rule 20 description 'Rule: allow_icmpv6'
set firewall ipv6 name wan-local rule 20 action 'accept'
set firewall ipv6 name wan-local rule 20 protocol 'icmpv6'
set firewall ipv6 name wan-local rule 30 description 'Rule: allow_dhcpv6'
set firewall ipv6 name wan-local rule 30 action 'accept'
set firewall ipv6 name wan-local rule 30 destination port '546'
set firewall ipv6 name wan-local rule 30 protocol 'udp'
set firewall ipv6 name wan-local rule 30 source port '547'

# WAN to TRUSTED
set firewall ipv6 name wan-trusted rule 20 description 'Rule: allow_icmpv6'
set firewall ipv6 name wan-trusted rule 20 action 'accept'
set firewall ipv6 name wan-trusted rule 20 protocol 'icmpv6'
set firewall ipv6 name wan-trusted rule 100 description 'Rule: allow_roon_arc'
set firewall ipv6 name wan-trusted rule 100 desination group port-group 'roon_arc_ports'
set firewall ipv6 name wan-trusted rule 100 desination address-mask ::7c7d:c6ff:fec7:26ac
set firewall ipv6 name wan-trusted rule 100 protocol 'tcp'
set firewall ipv6 name wan-trusted rule 100 action 'accept'
