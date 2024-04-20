#!/bin/vbash

# From LAN to GUEST
set firewall ipv4 name lan-guest default-action 'drop'

# From LAN to IOT
set firewall ipv4 name lan-iot default-action 'drop'

# From LAN to LOCAL
set firewall ipv4 name lan-local default-action 'drop'
set firewall ipv4 name lan-local rule 50 action 'accept'
set firewall ipv4 name lan-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name lan-local rule 50 destination port '67,68'
set firewall ipv4 name lan-local rule 50 protocol 'udp'
set firewall ipv4 name lan-local rule 50 source port '67,68'
set firewall ipv4 name lan-local rule 60 action 'accept'
set firewall ipv4 name lan-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name lan-local rule 60 destination port 'ntp'
set firewall ipv4 name lan-local rule 60 protocol 'udp'

# From LAN to SERVERS
set firewall ipv4 name lan-servers default-action 'drop'

# From LAN to CONTAINERS
set firewall ipv4 name lan-containers default-action 'accept'

# From LAN to TRUSTED
set firewall ipv4 name lan-trusted default-action 'drop'

# From LAN to WAN
set firewall ipv4 name lan-wan default-action 'accept'
