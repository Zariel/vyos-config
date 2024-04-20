#!/bin/vbash

# From IOT to WAN
set firewall ipv4 name iot-wan default-action 'accept'

# From IOT to GUEST
set firewall ipv4 name iot-guest default-action 'drop'
set firewall ipv4 name iot-guest default-log

# From IOT to LAN
set firewall ipv4 name iot-lan default-action 'drop'
set firewall ipv4 name iot-lan default-log

# From IOT to LOCAL
set firewall ipv4 name iot-local default-action 'drop'
set firewall ipv4 name iot-local default-log
set firewall ipv4 name iot-local rule 50 action 'accept'
set firewall ipv4 name iot-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name iot-local rule 50 destination port '67,68'
set firewall ipv4 name iot-local rule 50 protocol 'udp'
set firewall ipv4 name iot-local rule 50 source port '67,68'
set firewall ipv4 name iot-local rule 60 action 'accept'
set firewall ipv4 name iot-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name iot-local rule 60 destination port 'ntp'
set firewall ipv4 name iot-local rule 60 protocol 'udp'
set firewall ipv4 name iot-local rule 100 action 'accept'
set firewall ipv4 name iot-local rule 100 description 'Rule: accept_igmp'
set firewall ipv4 name iot-local rule 100 protocol '2'

# From IOT to SERVERS
set firewall ipv4 name iot-servers default-action 'drop'
set firewall ipv4 name iot-servers default-log
set firewall ipv4 name iot-servers rule 50 action 'accept'
set firewall ipv4 name iot-servers rule 50 description 'Rule: accept_plex_clients_to_plex'
set firewall ipv4 name iot-servers rule 50 destination group address-group 'k8s_plex'
set firewall ipv4 name iot-servers rule 50 destination port '32400'
set firewall ipv4 name iot-servers rule 50 source group address-group 'plex_clients'
set firewall ipv4 name iot-servers rule 50 protocol 'tcp'
set firewall ipv4 name iot-servers rule 60 action 'accept'
set firewall ipv4 name iot-servers rule 60 description 'Rule: accept_plex_clients_to_jellyfin'
set firewall ipv4 name iot-servers rule 60 destination group address-group 'k8s_jellyfin'
set firewall ipv4 name iot-servers rule 60 source group address-group 'plex_clients'
set firewall ipv4 name iot-servers rule 60 protocol 'tcp_udp'
set firewall ipv4 name iot-servers rule 70 action 'accept'
set firewall ipv4 name iot-servers rule 70 description 'Rule: accept_k8s_ingress'
set firewall ipv4 name iot-servers rule 70 destination group address-group 'k8s_ingress'
set firewall ipv4 name iot-servers rule 70 destination group port-group 'k8s_ingress'
set firewall ipv4 name iot-servers rule 70 protocol 'tcp'
set firewall ipv4 name iot-servers rule 70 source group address-group 'k8s_ingress_clients'

# From IOT to CONTAINERS
set firewall ipv4 name iot-containers default-action 'accept'
set firewall ipv4 name iot-containers rule 40 action 'accept'
set firewall ipv4 name iot-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name iot-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name iot-containers rule 40 protocol 'tcp_udp'

# From IOT to TRUSTED
set firewall ipv4 name iot-trusted default-action 'drop'
set firewall ipv4 name iot-trusted default-log
