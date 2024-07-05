#!/bin/vbash

# From TRUSTED to WAN
set firewall ipv6 name trusted-wan default-action 'accept'

# From TRUSTED to LOCAL
set firewall ipv6 name trusted-local rule 20 description 'Rule: allow_icmpv6'
set firewall ipv6 name trusted-local rule 20 action 'accept'
set firewall ipv6 name trusted-local rule 20 protocol 'icmpv6'
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
