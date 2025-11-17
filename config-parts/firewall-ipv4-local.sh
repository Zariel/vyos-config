#!/bin/vbash

# From LOCAL to GUEST
set firewall ipv4 name local-guest default-action 'drop'
set firewall ipv4 name local-guest default-log

# From LOCAL to IOT
set firewall ipv4 name local-iot default-action 'drop'
set firewall ipv4 name local-iot default-log
set firewall ipv4 name local-iot rule 110 action 'accept'
set firewall ipv4 name local-iot rule 110 description 'Rule: accept_mdns'
set firewall ipv4 name local-iot rule 110 destination port 'mdns'
set firewall ipv4 name local-iot rule 110 protocol 'udp'
set firewall ipv4 name local-iot rule 110 source port 'mdns'

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
set firewall ipv4 name local-servers rule 200 action 'accept'
set firewall ipv4 name local-servers rule 200 description 'Rule: accept_syslog_vector'
set firewall ipv4 name local-servers rule 200 protocol 'tcp'
set firewall ipv4 name local-servers rule 200 destination port '6001'
set firewall ipv4 name local-servers rule 200 destination address '10.45.0.2' # vector
set firewall ipv4 name local-servers rule 210 action 'accept'
set firewall ipv4 name local-servers rule 210 description 'Rule: accept_k8s_api'
set firewall ipv4 name local-servers rule 210 protocol 'tcp'
set firewall ipv4 name local-servers rule 210 destination port '6443'
set firewall ipv4 name local-servers rule 210 destination group address-group 'k8s_nodes'

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
set firewall ipv4 name local-trusted rule 110 action 'accept'
set firewall ipv4 name local-trusted rule 110 description 'Rule: accept_mdns'
set firewall ipv4 name local-trusted rule 110 destination port 'mdns'
set firewall ipv4 name local-trusted rule 110 protocol 'udp'
set firewall ipv4 name local-trusted rule 110 source port 'mdns'
set firewall ipv4 name local-trusted rule 400 description 'Rule: accept_wireguard'
set firewall ipv4 name local-trusted rule 400 source port '51820'
set firewall ipv4 name local-trusted rule 400 protocol 'udp'
set firewall ipv4 name local-trusted rule 400 action 'accept'

# From LOCAL to WAN
set firewall ipv4 name local-wan default-action 'accept'

# From LOCAL to TRANSIT
set firewall ipv4 name local-transit default-action 'drop'
set firewall ipv4 name local-transit default-log
# Allow OSPF from OSPF zone to local (router itself)
set firewall ipv4 name local-transit rule 10 action accept
set firewall ipv4 name local-transit rule 10 protocol ospf
set firewall ipv4 name local-transit rule 10 description 'Allow OSPF'

# Allow ICMP for ping testing
set firewall ipv4 name local-transit rule 20 action accept
set firewall ipv4 name local-transit rule 20 protocol icmp
set firewall ipv4 name local-transit rule 20 description 'Allow ICMP'

# From LOCAL to VPN
set firewall ipv4 name local-vpn default-action 'drop'
set firewall ipv4 name local-vpn default-log
set firewall ipv4 name local-vpn rule 10 action 'accept'
set firewall ipv4 name local-vpn rule 10 description 'Allow DNS responses'
set firewall ipv4 name local-vpn rule 10 protocol 'udp'
set firewall ipv4 name local-vpn rule 10 source port '53'
set firewall ipv4 name local-vpn rule 11 action 'accept'
set firewall ipv4 name local-vpn rule 11 description 'Allow DHCP responses'
set firewall ipv4 name local-vpn rule 11 protocol 'udp'
set firewall ipv4 name local-vpn rule 11 source port '67'
