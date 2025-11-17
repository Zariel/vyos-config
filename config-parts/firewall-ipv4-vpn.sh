#!/bin/vbash

# VPN VLAN Kill Switch and Isolation Rules
# Complete isolation: VPN zone can ONLY access local (router) for DHCP/DNS
# All other traffic is blocked - VRF routing forces Internet traffic through wg02

# Block direct access to WAN (kill switch)
set firewall ipv4 name vpn-wan rule 1 action 'drop'
set firewall ipv4 name vpn-wan rule 1 description 'Kill switch: block direct WAN access'
set firewall ipv4 name vpn-wan rule 1 log

# Block access to all other internal zones (complete isolation)
set firewall ipv4 name vpn-servers rule 1 action 'drop'
set firewall ipv4 name vpn-servers rule 1 description 'Isolate from SERVERS'

set firewall ipv4 name vpn-trusted rule 1 action 'drop'
set firewall ipv4 name vpn-trusted rule 1 description 'Isolate from TRUSTED'

set firewall ipv4 name vpn-iot rule 1 action 'drop'
set firewall ipv4 name vpn-iot rule 1 description 'Isolate from IOT'

set firewall ipv4 name vpn-guest rule 1 action 'drop'
set firewall ipv4 name vpn-guest rule 1 description 'Isolate from GUEST'

set firewall ipv4 name vpn-containers rule 1 action 'drop'
set firewall ipv4 name vpn-containers rule 1 description 'Isolate from CONTAINERS'

set firewall ipv4 name vpn-transit rule 1 action 'drop'
set firewall ipv4 name vpn-transit rule 1 description 'Isolate from TRANSIT'

set firewall ipv4 name vpn-lan rule 1 action 'drop'
set firewall ipv4 name vpn-lan rule 1 description 'Isolate from LAN'

# Allow minimal access to router itself (for DHCP and DNS only)
set firewall ipv4 name vpn-local rule 10 action 'accept'
set firewall ipv4 name vpn-local rule 10 description 'Allow DNS'
set firewall ipv4 name vpn-local rule 10 protocol 'udp'
set firewall ipv4 name vpn-local rule 10 destination port '53'

set firewall ipv4 name vpn-local rule 11 action 'accept'
set firewall ipv4 name vpn-local rule 11 description 'Allow DHCP'
set firewall ipv4 name vpn-local rule 11 protocol 'udp'
set firewall ipv4 name vpn-local rule 11 destination port '67,68'

set firewall ipv4 name vpn-local rule 13 action 'accept'
set firewall ipv4 name vpn-local rule 13 description 'Allow ICMP to router'
set firewall ipv4 name vpn-local rule 13 protocol 'icmp'
