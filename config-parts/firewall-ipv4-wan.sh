#!/bin/vbash

# From WAN to GUEST
set firewall ipv4 name wan-guest default-action 'drop'

# From WAN to IOT
set firewall ipv4 name wan-iot default-action 'drop'

# From WAN to LAN
set firewall ipv4 name wan-lan default-action 'drop'

# From WAN to LOCAL
set firewall ipv4 name wan-local default-action 'drop'

set firewall ipv4 name wan-local rule 100 action 'accept'
set firewall ipv4 name wan-local rule 100 description 'Rule: accept_wireguard'
set firewall ipv4 name wan-local rule 100 destination port '51820'
set firewall ipv4 name wan-local rule 100 protocol 'udp'

# From WAN to SERVERS
set firewall ipv4 name wan-servers default-action 'drop'
set firewall ipv4 name wan-servers rule 100 description 'Rule: qbittorrent'
set firewall ipv4 name wan-servers rule 100 destination port '50413'
set firewall ipv4 name wan-servers rule 100 destination address '10.45.0.24'
set firewall ipv4 name wan-servers rule 100 protocol 'tcp'
set firewall ipv4 name wan-servers rule 100 connection-status nat 'destination'
set firewall ipv4 name wan-servers rule 100 action 'accept'


# From WAN to CONTAINERS
set firewall ipv4 name wan-containers default-action 'drop'

# From WAN to TRUSTED
set firewall ipv4 name wan-trusted default-action 'drop'

# From WAN to TRANSIT
set firewall ipv4 name wan-transit rule 100 action accept
set firewall ipv4 name wan-transit rule 100 description 'Rule: qbittorrent'
set firewall ipv4 name wan-transit rule 100 destination port '50413'
set firewall ipv4 name wan-transit rule 100 destination address '10.45.0.24'
set firewall ipv4 name wan-transit rule 100 protocol 'tcp'
set firewall ipv4 name wan-transit rule 100 connection-status nat 'destination'
