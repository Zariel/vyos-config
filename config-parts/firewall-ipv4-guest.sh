#!/bin/vbash

# From GUEST to WAN
set firewall ipv4 name guest-wan default-action 'accept'

# From GUEST to IOT
set firewall ipv4 name guest-iot default-action 'drop'
set firewall ipv4 name guest-iot default-log

# From GUEST to LAN
set firewall ipv4 name guest-lan default-action 'drop'
set firewall ipv4 name guest-lan default-log

# From GUEST to LOCAL
set firewall ipv4 name guest-local default-action 'drop'
set firewall ipv4 name guest-local default-log
set firewall ipv4 name guest-local rule 50 action 'accept'
set firewall ipv4 name guest-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name guest-local rule 50 destination port '67,68'
set firewall ipv4 name guest-local rule 50 protocol 'udp'
set firewall ipv4 name guest-local rule 50 source port '67,68'

# From GUEST to CONTAINERS
set firewall ipv4 name guest-containers default-action 'drop'
set firewall ipv4 name guest-containers default-log
set firewall ipv4 name guest-containers rule 40 action 'accept'
set firewall ipv4 name guest-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name guest-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name guest-containers rule 40 protocol 'tcp_udp'

# From GUEST to SERVERS
set firewall ipv4 name guest-servers default-action 'drop'
set firewall ipv4 name guest-servers default-log

# From GUEST to TRUSTED
set firewall ipv4 name guest-trusted default-action 'drop'
set firewall ipv4 name guest-trusted default-log

# From GUEST to TRANSIT
set firewall ipv4 name guest-trusted default-action 'drop'
set firewall ipv4 name guest-trusted default-log

set firewall ipv4 name guest-transit rule 10 action accept
set firewall ipv4 name guest-transit rule 10 description 'Allow access to DNS'
set firewall ipv4 name guest-transit rule 10 destination port '53'
set firewall ipv4 name guest-transit rule 10 destination address '172.53.53.53'
set firewall ipv4 name guest-transit rule 10 protocol 'tcp_udp'
