#!/bin/vbash

# From TRUSTED to GUEST
set firewall ipv4 name trusted-guest default-action 'drop'
set firewall ipv4 name trusted-guest default-log

# From TRUSTED to IOT
set firewall ipv4 name trusted-iot default-action 'accept'

# From TRUSTED to LAN
set firewall ipv4 name trusted-lan default-action 'accept'

# From TRUSTED to LOCAL
set firewall ipv4 name trusted-local default-action 'drop'
set firewall ipv4 name trusted-local default-log
set firewall ipv4 name trusted-local rule 50 action 'accept'
set firewall ipv4 name trusted-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name trusted-local rule 50 destination port '67,68'
set firewall ipv4 name trusted-local rule 50 protocol 'udp'
set firewall ipv4 name trusted-local rule 50 source port '67,68'
set firewall ipv4 name trusted-local rule 60 action 'accept'
set firewall ipv4 name trusted-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name trusted-local rule 60 destination port 'ntp'
set firewall ipv4 name trusted-local rule 60 protocol 'udp'
set firewall ipv4 name trusted-local rule 100 action 'accept'
set firewall ipv4 name trusted-local rule 100 description 'Rule: accept_igmp'
set firewall ipv4 name trusted-local rule 100 protocol '2'
set firewall ipv4 name trusted-local rule 110 action 'accept'
set firewall ipv4 name trusted-local rule 110 description 'Rule: accept_mdns'
set firewall ipv4 name trusted-local rule 110 destination port 'mdns'
set firewall ipv4 name trusted-local rule 110 protocol 'udp'
set firewall ipv4 name trusted-local rule 110 source port 'mdns'
set firewall ipv4 name trusted-local rule 111 action 'accept'
set firewall ipv4 name trusted-local rule 111 description 'Rule: accept_mdns_2'
set firewall ipv4 name trusted-local rule 111 destination address '255.255.255.255'
set firewall ipv4 name trusted-local rule 111 destination port '9'
set firewall ipv4 name trusted-local rule 111 protocol 'udp'
set firewall ipv4 name trusted-local rule 400 action 'accept'
set firewall ipv4 name trusted-local rule 400 description 'Rule: accept_ssh'
set firewall ipv4 name trusted-local rule 400 destination port 'ssh'
set firewall ipv4 name trusted-local rule 400 protocol 'tcp'
set firewall ipv4 name trusted-local rule 410 action 'accept'
set firewall ipv4 name trusted-local rule 410 description 'Rule: accept_vyos_api'
set firewall ipv4 name trusted-local rule 410 destination port '8443'
set firewall ipv4 name trusted-local rule 410 protocol 'tcp'
set firewall ipv4 name trusted-local rule 420 action 'accept'
set firewall ipv4 name trusted-local rule 420 description 'Rule: accept_wireguard'
set firewall ipv4 name trusted-local rule 420 destination port '51820'
set firewall ipv4 name trusted-local rule 420 protocol 'udp'
# From TRUSTED to SERVERS
set firewall ipv4 name trusted-servers default-action 'accept'

# From TRUSTED to CONTAINERS
set firewall ipv4 name trusted-containers default-action 'accept'
set firewall ipv4 name trusted-containers rule 40 action 'accept'
set firewall ipv4 name trusted-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name trusted-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name trusted-containers rule 40 protocol 'tcp_udp'

# From TRUSTED to WAN
set firewall ipv4 name trusted-wan default-action 'accept'
