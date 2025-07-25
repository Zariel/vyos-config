#!/bin/vbash

# From SERVERS to GUEST
set firewall ipv4 name servers-guest default-action 'drop'
set firewall ipv4 name servers-guest default-log

# From SERVERS to IOT
set firewall ipv4 name servers-iot default-action 'drop'
set firewall ipv4 name servers-iot default-log

# From SERVERS to LAN
set firewall ipv4 name servers-lan default-action 'drop'
set firewall ipv4 name servers-lan default-log

# From SERVERS to LOCAL
set firewall ipv4 name servers-local default-action 'drop'
set firewall ipv4 name servers-local default-log
set firewall ipv4 name servers-local rule 50 action 'accept'
set firewall ipv4 name servers-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name servers-local rule 50 destination port '67,68'
set firewall ipv4 name servers-local rule 50 protocol 'udp'
set firewall ipv4 name servers-local rule 50 source port '67,68'
set firewall ipv4 name servers-local rule 60 action 'accept'
set firewall ipv4 name servers-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name servers-local rule 60 destination port 'ntp'
set firewall ipv4 name servers-local rule 60 protocol 'udp'
set firewall ipv4 name servers-local rule 70 action 'accept'
set firewall ipv4 name servers-local rule 70 description 'Rule: accept_bgp'
set firewall ipv4 name servers-local rule 70 destination port 'bgp'
set firewall ipv4 name servers-local rule 70 protocol 'tcp'
set firewall ipv4 name servers-local rule 80 action 'accept'
set firewall ipv4 name servers-local rule 80 description 'Rule: accept_tftp'
set firewall ipv4 name servers-local rule 80 destination port '69'
set firewall ipv4 name servers-local rule 80 protocol 'udp'
set firewall ipv4 name servers-local rule 100 action 'accept'
set firewall ipv4 name servers-local rule 100 description 'Rule: accept_node_exporter_from_k8s_nodes_and_pods'
set firewall ipv4 name servers-local rule 100 destination port '9100'
set firewall ipv4 name servers-local rule 100 protocol 'tcp'
set firewall ipv4 name servers-local rule 100 source group network-group 'k8s_pods'
set firewall ipv4 name servers-local rule 110 action 'accept'
set firewall ipv4 name servers-local rule 110 description 'Rule: accept_speedtest_exporter_from_k8s_nodes'
set firewall ipv4 name servers-local rule 110 destination port '9798'
set firewall ipv4 name servers-local rule 110 protocol 'tcp'
set firewall ipv4 name servers-local rule 110 source group network-group 'k8s_pods'

# From SERVERS to CONTAINERS
set firewall ipv4 name servers-containers default-action 'accept'
set firewall ipv4 name servers-containers rule 40 action 'accept'
set firewall ipv4 name servers-containers rule 40 description 'Rule: accept_dns'
set firewall ipv4 name servers-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name servers-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name servers-containers rule 100 action 'accept'
set firewall ipv4 name servers-containers rule 100 description 'Rule: accept_k8s_nodes'
set firewall ipv4 name servers-containers rule 100 protocol 'tcp'
set firewall ipv4 name servers-containers rule 100 source group network-group 'k8s_pods'

# From SERVERS to TRUSTED
set firewall ipv4 name servers-trusted default-action 'drop'
set firewall ipv4 name servers-trusted default-log
set firewall ipv4 name servers-trusted rule 100 action 'accept'
set firewall ipv4 name servers-trusted rule 100 description 'Rule: accept_node_exporter_from_k8s_nodes_and_pods'
set firewall ipv4 name servers-trusted rule 100 destination port '9100'
set firewall ipv4 name servers-trusted rule 100 destination address '10.1.2.54'
set firewall ipv4 name servers-trusted rule 100 protocol 'tcp'
set firewall ipv4 name servers-trusted rule 100 source group network-group 'k8s_pods'

# From SERVERS to WAN
set firewall ipv4 name servers-wan default-action 'accept'
