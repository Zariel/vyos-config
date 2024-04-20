#!/bin/vbash

# From WAN to GUEST
set firewall ipv4 name wan-guest default-action 'drop'
set firewall ipv4 name wan-guest default-log

# From WAN to IOT
set firewall ipv4 name wan-iot default-action 'drop'
set firewall ipv4 name wan-iot default-log

# From WAN to LAN
set firewall ipv4 name wan-lan default-action 'drop'
set firewall ipv4 name wan-lan default-log

# From WAN to LOCAL
set firewall ipv4 name wan-local default-action 'drop'
set firewall ipv4 name wan-local default-log

# From WAN to SERVERS
set firewall ipv4 name wan-servers default-action 'drop'
set firewall ipv4 name wan-servers default-log

# From WAN to CONTAINERS
set firewall ipv4 name wan-containers default-action 'drop'
set firewall ipv4 name wan-containers default-log

# From WAN to TRUSTED
set firewall ipv4 name wan-trusted default-action 'drop'
set firewall ipv4 name wan-trusted default-log
set firewall ipv4 name wan-trusted rule 100 description 'Rule: accept_roon_arc'
set firewall ipv4 name wan-trusted rule 100 destination port '59453'
set firewall ipv4 name wan-trusted rule 100 destination address '10.1.2.60'
set firewall ipv4 name wan-trusted rule 100 protocol 'tcp'
set firewall ipv4 name wan-trusted rule 100 action 'accept'
