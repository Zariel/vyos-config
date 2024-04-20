#!/bin/vbash

# From LOCAL to GUEST
set firewall ipv4 name local-guest default-action 'drop'
set firewall ipv4 name local-guest default-log

# From LOCAL to IOT
set firewall ipv4 name local-iot default-action 'drop'
set firewall ipv4 name local-iot default-log

# From LOCAL to LAN
set firewall ipv4 name local-lan default-action 'drop'
set firewall ipv4 name local-lan default-log

# From LOCAL to SERVERS
set firewall ipv4 name local-servers default-action 'drop'
set firewall ipv4 name local-servers default-log
set firewall ipv4 name local-servers rule 40 action 'accept'
set firewall ipv4 name local-servers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name local-servers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name local-servers rule 40 protocol 'tcp_udp'
set firewall ipv4 name local-servers rule 70 action 'accept'
set firewall ipv4 name local-servers rule 70 description 'Rule: accept_bgp'
set firewall ipv4 name local-servers rule 70 destination port 'bgp'
set firewall ipv4 name local-servers rule 70 protocol 'tcp'
# TODO: This needs to be more specific
set firewall ipv4 name local-servers rule 80 action 'accept'
set firewall ipv4 name local-servers rule 80 description 'Rule: accept_pxe'
set firewall ipv4 name local-servers rule 80 protocol 'udp'
set firewall ipv4 name local-servers rule 80 log

# From LOCAL to CONTAINERS
set firewall ipv4 name local-containers default-action 'accept'
set firewall ipv4 name local-containers rule 40 action 'accept'
set firewall ipv4 name local-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name local-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name local-containers rule 40 protocol 'tcp_udp'

# From LOCAL to TRUSTED
set firewall ipv4 name local-trusted default-action 'drop'
set firewall ipv4 name local-trusted default-log
set firewall ipv4 name local-trusted rule 100 action 'accept'
set firewall ipv4 name local-trusted rule 100 description 'Rule: accept_igmp'
set firewall ipv4 name local-trusted rule 100 protocol '2'

# From LOCAL to WAN
set firewall ipv4 name local-wan default-action 'accept'
