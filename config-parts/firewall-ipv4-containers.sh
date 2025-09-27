#!/bin/vbash

# From CONTAINERS to GUEST
set firewall ipv4 name containers-guest default-action 'drop'
set firewall ipv4 name containers-guest default-log

# From CONTAINERS to IOT
set firewall ipv4 name containers-iot default-action 'drop'
set firewall ipv4 name containers-iot default-log

# From CONTAINERS to LAN
set firewall ipv4 name containers-lan default-action 'drop'
set firewall ipv4 name containers-lan default-log

# From CONTAINERS to LOCAL
set firewall ipv4 name containers-local default-action 'drop'
set firewall ipv4 name containers-local default-log
set firewall ipv4 name containers-local rule 40 action 'accept'
set firewall ipv4 name containers-local rule 40 description 'Rule: accept_dns'
set firewall ipv4 name containers-local rule 40 destination port 'domain,domain-s'
set firewall ipv4 name containers-local rule 40 protocol 'tcp_udp'
set firewall ipv4 name containers-local rule 50 action 'accept'
set firewall ipv4 name containers-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name containers-local rule 50 destination port '67,68'
set firewall ipv4 name containers-local rule 50 protocol 'udp'
set firewall ipv4 name containers-local rule 50 source port '67,68'
set firewall ipv4 name containers-local rule 60 action 'accept'
set firewall ipv4 name containers-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name containers-local rule 60 destination port 'ntp'
set firewall ipv4 name containers-local rule 60 protocol 'udp'

# From CONTAINERS to SERVERS
set firewall ipv4 name containers-servers default-action 'accept'

# From CONTAINERS to TRUSTED
set firewall ipv4 name containers-trusted default-action 'drop'
set firewall ipv4 name containers-trusted default-log

# From CONTAINERS to WAN
set firewall ipv4 name containers-wan default-action 'accept'

# From CONTAINERS to TRANSIT
set firewall ipv4 name containers-transit default-action 'drop'
set firewall ipv4 name containers-transit rule 100 action 'accept'
set firewall ipv4 name containers-transit rule 100 description 'Rule: allow haproxy to access talos'
set firewall ipv4 name containers-transit rule 100 destination group address-group 'k8s_nodes'
set firewall ipv4 name containers-transit rule 100 destination port '6443,50000'
set firewall ipv4 name containers-transit rule 100 protocol 'tcp'

set firewall ipv4 name containers-transit rule 110 action 'accept'
set firewall ipv4 name containers-transit rule 110 description 'Rule: allow dnsdist to access in cluster bind'
set firewall ipv4 name containers-transit rule 110 destination address 10.45.0.55
set firewall ipv4 name containers-transit rule 110 destination port '53'
set firewall ipv4 name containers-transit rule 110 protocol 'tcp_udp'
