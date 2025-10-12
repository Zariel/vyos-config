#!/bin/vbash

# From LOCAL to WAN
set firewall ipv6 name local-wan default-action 'accept'

# From LOCAL to TRUSTED
set firewall ipv6 name local-trusted rule 30 description 'Rule: allow_dhcpv6'
set firewall ipv6 name local-trusted rule 30 action 'accept'
set firewall ipv6 name local-trusted rule 30 destination port '546'
set firewall ipv6 name local-trusted rule 30 protocol 'udp'
set firewall ipv6 name local-trusted rule 30 source port '547'
set firewall ipv6 name local-trusted rule 110 action 'accept'
set firewall ipv6 name local-trusted rule 110 description 'Rule: accept_mdns'
set firewall ipv6 name local-trusted rule 110 destination port 'mdns'
set firewall ipv6 name local-trusted rule 110 protocol 'udp'

# From LOCAL to IOT
set firewall ipv6 name local-iot rule 110 action 'accept'
set firewall ipv6 name local-iot rule 110 description 'Rule: accept_mdns'
set firewall ipv6 name local-iot rule 110 destination port 'mdns'
set firewall ipv6 name local-iot rule 110 protocol 'udp'
set firewall ipv6 name local-iot rule 110 source port 'mdns'

set firewall ipv6 name local-transit rule 10 action accept
set firewall ipv6 name local-transit rule 10 protocol ospf
set firewall ipv6 name local-transit rule 10 description 'Allow OSPF'
