#!/bin/vbash

# From LAN to GUEST
set firewall ipv4 name lan-guest default-action 'drop'
set firewall ipv4 name lan-guest default-log

# From LAN to IOT
set firewall ipv4 name lan-iot default-action 'drop'
set firewall ipv4 name lan-iot default-log

# From LAN to LOCAL
set firewall ipv4 name lan-local default-action 'drop'
set firewall ipv4 name lan-local default-log
set firewall ipv4 name lan-local rule 50 action 'accept'
set firewall ipv4 name lan-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name lan-local rule 50 destination port '67,68'
set firewall ipv4 name lan-local rule 50 protocol 'udp'
set firewall ipv4 name lan-local rule 50 source port '67,68'
set firewall ipv4 name lan-local rule 60 action 'accept'
set firewall ipv4 name lan-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name lan-local rule 60 destination port 'ntp'
set firewall ipv4 name lan-local rule 60 protocol 'udp'
set firewall ipv4 name lan-local rule 80 action 'accept'
set firewall ipv4 name lan-local rule 80 description 'Rule: accept_tftp'
set firewall ipv4 name lan-local rule 80 destination port '69'
set firewall ipv4 name lan-local rule 80 protocol 'udp'
set firewall ipv4 name lan-local rule 400 action 'accept'
set firewall ipv4 name lan-local rule 400 description 'Rule: accept_ssh'
set firewall ipv4 name lan-local rule 400 destination port 'ssh'
set firewall ipv4 name lan-local rule 400 protocol 'tcp'

# From LAN to SERVERS
set firewall ipv4 name lan-servers default-action 'drop'
set firewall ipv4 name lan-servers default-log
set firewall ipv4 name lan-servers rule 100 action 'accept'
set firewall ipv4 name lan-servers rule 100 description 'Rule: accept_snmp'
set firewall ipv4 name lan-servers rule 100 destination port '161,162'
set firewall ipv4 name lan-servers rule 100 protocol 'tcp_udp'
set firewall ipv4 name lan-servers rule 110 action 'accept'
set firewall ipv4 name lan-servers rule 110 description 'Rule: accept_pikvm_tesmart'
set firewall ipv4 name lan-servers rule 110 destination port '5000'
set firewall ipv4 name lan-servers rule 110 destination address '10.1.1.51'
set firewall ipv4 name lan-servers rule 110 source address '10.1.0.100'
set firewall ipv4 name lan-servers rule 110 protocol 'tcp_udp'

# From LAN to CONTAINERS
set firewall ipv4 name lan-containers default-action 'accept'
set firewall ipv4 name lan-containers rule 40 action 'accept'
set firewall ipv4 name lan-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name lan-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name lan-containers rule 40 protocol 'tcp_udp'

# From LAN to TRUSTED
set firewall ipv4 name lan-trusted default-action 'drop'
set firewall ipv4 name lan-trusted default-log
set firewall ipv4 name lan-trusted rule 100 action 'accept'
set firewall ipv4 name lan-trusted rule 100 description 'Rule: allow sflow'
set firewall ipv4 name lan-trusted rule 100 destination port '6343'
set firewall ipv4 name lan-trusted rule 100 destination address 10.1.2.14
set firewall ipv4 name lan-trusted rule 100 protocol 'udp'

# From LAN to WAN
set firewall ipv4 name lan-wan default-action 'accept'
