#!/bin/vbash

# From TRUSTED to GUEST
set firewall ipv4 name trusted-guest default-action 'drop'
set firewall ipv4 name trusted-guest description 'From TRUSTED to GUEST'
set firewall ipv4 name trusted-guest default-log
set firewall ipv4 name trusted-guest rule 999 action 'drop'
set firewall ipv4 name trusted-guest rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-guest rule 999 state invalid
set firewall ipv4 name trusted-guest rule 999 log

# From TRUSTED to IOT
set firewall ipv4 name trusted-iot default-action 'accept'
set firewall ipv4 name trusted-iot description 'From TRUSTED to IOT'
set firewall ipv4 name trusted-iot rule 999 action 'drop'
set firewall ipv4 name trusted-iot rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-iot rule 999 state invalid
set firewall ipv4 name trusted-iot rule 999 log

# From TRUSTED to LAN
set firewall ipv4 name trusted-lan default-action 'accept'
set firewall ipv4 name trusted-lan description 'From TRUSTED to LAN'
set firewall ipv4 name trusted-lan rule 999 action 'drop'
set firewall ipv4 name trusted-lan rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-lan rule 999 state invalid
set firewall ipv4 name trusted-lan rule 999 log

# From TRUSTED to LOCAL
set firewall ipv4 name trusted-local default-action 'drop'
set firewall ipv4 name trusted-local description 'From TRUSTED to LOCAL'
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
set firewall ipv4 name trusted-local rule 210 action 'accept'
set firewall ipv4 name trusted-local rule 400 action 'accept'
set firewall ipv4 name trusted-local rule 400 description 'Rule: accept_ssh'
set firewall ipv4 name trusted-local rule 400 destination port 'ssh'
set firewall ipv4 name trusted-local rule 400 protocol 'tcp'
set firewall ipv4 name trusted-local rule 410 action 'accept'
set firewall ipv4 name trusted-local rule 410 description 'Rule: accept_vyos_api'
set firewall ipv4 name trusted-local rule 410 destination port '8443'
set firewall ipv4 name trusted-local rule 410 protocol 'tcp'

set firewall ipv4 name trusted-local rule 999 action 'drop'
set firewall ipv4 name trusted-local rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-local rule 999 state invalid
set firewall ipv4 name trusted-local rule 999 log

# From TRUSTED to SERVERS
set firewall ipv4 name trusted-servers default-action 'accept'
set firewall ipv4 name trusted-servers description 'From TRUSTED to SERVERS'
set firewall ipv4 name trusted-servers rule 999 action 'drop'
set firewall ipv4 name trusted-servers rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-servers rule 999 state invalid
set firewall ipv4 name trusted-servers rule 999 log

# From TRUSTED to CONTAINERS
set firewall ipv4 name trusted-containers default-action 'accept'
set firewall ipv4 name trusted-containers description 'From TRUSTED to CONTAINERS'
set firewall ipv4 name trusted-containers rule 40 action 'accept'
set firewall ipv4 name trusted-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name trusted-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name trusted-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name trusted-containers rule 999 action 'drop'
set firewall ipv4 name trusted-containers rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-containers rule 999 state invalid
set firewall ipv4 name trusted-containers rule 999 log

# From TRUSTED to WAN
set firewall ipv4 name trusted-wan default-action 'accept'
set firewall ipv4 name trusted-wan description 'From TRUSTED to WAN'

# From TRUSTED to K8S
set firewall ipv4 name trusted-k8s default-action 'accept'
set firewall ipv4 name trusted-k8s rule 999 action 'drop'
set firewall ipv4 name trusted-k8s rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name trusted-k8s rule 999 state invalid
set firewall ipv4 name trusted-k8s rule 999 log
