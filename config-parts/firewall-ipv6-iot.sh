#!/bin/vbash

# From IOT to WAN
set firewall ipv6 name iot-wan default-action 'accept'

# From IOT to LOCAL
set firewall ipv6 name iot-local default-action 'drop'
set firewall ipv6 name iot-local default-log
set firewall ipv6 name iot-local rule 110 action 'accept'
set firewall ipv6 name iot-local rule 110 description 'Rule: accept_mdns'
set firewall ipv6 name iot-local rule 110 destination port 'mdns'
set firewall ipv6 name iot-local rule 110 protocol 'udp'
set firewall ipv6 name iot-local rule 110 source port 'mdns'

# From IOT to CONTAINERS
set firewall ipv6 name iot-containers default-action 'accept'
set firewall ipv6 name iot-containers rule 40 action 'accept'
set firewall ipv6 name iot-containers rule 40 description 'Rule: accept_dns'
set firewall ipv6 name iot-containers rule 40 destination port 'domain,domain-s'
set firewall ipv6 name iot-containers rule 40 protocol 'tcp_udp'

# From IOT to TRANSIT
set firewall ipv6 name iot-transit default-action 'drop'
set firewall ipv6 name iot-transit rule 53 action 'accept'
set firewall ipv6 name iot-transit rule 53 description 'Rule: accept_dns'
set firewall ipv6 name iot-transit rule 53 destination port 'domain,domain-s'
set firewall ipv6 name iot-transit rule 53 destination address 'fd74:f571:d3bd:53::53'
set firewall ipv6 name iot-transit rule 53 protocol 'tcp_udp'

