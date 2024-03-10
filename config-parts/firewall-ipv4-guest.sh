#!/bin/vbash

# From GUEST to WAN
set firewall ipv4 name guest-wan default-action 'accept'
set firewall ipv4 name guest-wan description 'From GUEST to WAN'

# From GUEST to IOT
set firewall ipv4 name guest-iot default-action 'drop'
set firewall ipv4 name guest-iot description 'From GUEST to IOT'
set firewall ipv4 name guest-iot default-log
set firewall ipv4 name guest-iot rule 999 action 'drop'
set firewall ipv4 name guest-iot rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name guest-iot rule 999 state invalid
set firewall ipv4 name guest-iot rule 999 log

# From GUEST to LAN
set firewall ipv4 name guest-lan default-action 'drop'
set firewall ipv4 name guest-lan description 'From GUEST to LAN'
set firewall ipv4 name guest-lan default-log
set firewall ipv4 name guest-lan rule 999 action 'drop'
set firewall ipv4 name guest-lan rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name guest-lan rule 999 state invalid
set firewall ipv4 name guest-lan rule 999 log

# From GUEST to LOCAL
set firewall ipv4 name guest-local default-action 'drop'
set firewall ipv4 name guest-local description 'From GUEST to LOCAL'
set firewall ipv4 name guest-local default-log
set firewall ipv4 name guest-local rule 50 action 'accept'
set firewall ipv4 name guest-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name guest-local rule 50 destination port '67,68'
set firewall ipv4 name guest-local rule 50 protocol 'udp'
set firewall ipv4 name guest-local rule 50 source port '67,68'
set firewall ipv4 name guest-local rule 999 action 'drop'
set firewall ipv4 name guest-local rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name guest-local rule 999 state invalid
set firewall ipv4 name guest-local rule 999 log

# From GUEST to CONTAINERS
set firewall ipv4 name guest-containers default-action 'drop'
set firewall ipv4 name guest-containers description 'From GUEST to CONTAINERS'
set firewall ipv4 name guest-containers default-log
set firewall ipv4 name guest-containers rule 40 action 'accept'
set firewall ipv4 name guest-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name guest-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name guest-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name guest-containers rule 999 action 'drop'
set firewall ipv4 name guest-containers rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name guest-containers rule 999 state invalid
set firewall ipv4 name guest-containers rule 999 log

# From GUEST to SERVERS
set firewall ipv4 name guest-servers default-action 'drop'
set firewall ipv4 name guest-servers description 'From GUEST to SERVERS'
set firewall ipv4 name guest-servers default-log
set firewall ipv4 name guest-servers rule 999 action 'drop'
set firewall ipv4 name guest-servers rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name guest-servers rule 999 state invalid
set firewall ipv4 name guest-servers rule 999 log

# From GUEST to TRUSTED
set firewall ipv4 name guest-trusted default-action 'drop'
set firewall ipv4 name guest-trusted description 'From GUEST to TRUSTED'
set firewall ipv4 name guest-trusted default-log
set firewall ipv4 name guest-trusted rule 999 action 'drop'
set firewall ipv4 name guest-trusted rule 999 description 'Rule: drop_invalid'
set firewall ipv4 name guest-trusted rule 999 state invalid
set firewall ipv4 name guest-trusted rule 999 log
