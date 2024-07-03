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
