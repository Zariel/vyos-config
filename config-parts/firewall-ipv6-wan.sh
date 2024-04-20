#!/bin/vbash

# WAN to LOCAL
set firewall ipv6 name wan-local default-action 'drop'
set firewall ipv6 name wan-local rule 10 action 'accept'
set firewall ipv6 name wan-local rule 10 state established 
set firewall ipv6 name wan-local rule 10 state related 
set firewall ipv6 name wan-local rule 20 action 'accept'
set firewall ipv6 name wan-local rule 20 protocol 'icmpv6'
set firewall ipv6 name wan-local rule 30 action 'accept'
set firewall ipv6 name wan-local rule 30 destination port '546'
set firewall ipv6 name wan-local rule 30 protocol 'udp'
set firewall ipv6 name wan-local rule 30 source port '547'
set firewall ipv6 name wan-local rule 999 action 'drop'
set firewall ipv6 name wan-local rule 999 description 'Rule: drop_invalid'
set firewall ipv6 name wan-local rule 999 state invalid
set firewall ipv6 name wan-local rule 999 log
