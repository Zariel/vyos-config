#!/bin/vbash

# From TRUSTED to WAN
set firewall ipv6 name trusted-wan default-action 'accept'

# From TRUSTED to LOCAL
set firewall ipv6 name trusted-local rule 110 action 'accept'
set firewall ipv6 name trusted-local rule 110 description 'Rule: accept_mdns'
set firewall ipv6 name trusted-local rule 110 destination port 'mdns'
set firewall ipv6 name trusted-local rule 110 protocol 'udp'
set firewall ipv6 name trusted-local rule 110 source port 'mdns'
set firewall ipv6 name trusted-local rule 400 action 'accept'
set firewall ipv6 name trusted-local rule 400 description 'Rule: accept_ssh'
set firewall ipv6 name trusted-local rule 400 destination port 'ssh'
set firewall ipv6 name trusted-local rule 400 protocol 'tcp'
set firewall ipv6 name trusted-local default-action 'drop'
set firewall ipv6 name trusted-local default-log

# From TRUSTED to CONTAINERS
set firewall ipv6 name trusted-containers default-action 'accept'
set firewall ipv6 name trusted-containers rule 40 action 'accept'
set firewall ipv6 name trusted-containers rule 40 description 'Rule: accept_dns'
set firewall ipv6 name trusted-containers rule 40 destination port 'domain,domain-s'
set firewall ipv6 name trusted-containers rule 40 protocol 'tcp_udp'

# From TRUSTED to TRANSIT
set firewall ipv6 name trusted-transit default-action 'drop'
set firewall ipv6 name trusted-transit rule 53 action 'accept'
set firewall ipv6 name trusted-transit rule 53 description 'Rule: accept_dns'
set firewall ipv6 name trusted-transit rule 53 destination port 'domain,domain-s'
set firewall ipv6 name trusted-transit rule 53 destination address 'fd74:f571:d3bd:53::53'
set firewall ipv6 name trusted-transit rule 53 protocol 'tcp_udp'
