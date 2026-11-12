#!/bin/vbash

# From LOCAL to GUEST
set firewall ipv4 name local-guest default-action 'drop'
set firewall ipv4 name local-guest default-log

# From LOCAL to IOT
set firewall ipv4 name local-iot default-action 'drop'
set firewall ipv4 name local-iot default-log
set firewall ipv4 name local-iot rule 100 action accept
set firewall ipv4 name local-iot rule 100 description 'Rule: accept_igmp'
set firewall ipv4 name local-iot rule 100 protocol 2
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
set firewall ipv4 name local-trusted rule 10 action 'accept'
set firewall ipv4 name local-trusted rule 10 description 'VRRP to trusted backup VM'
set firewall ipv4 name local-trusted rule 10 protocol '112'
set firewall ipv4 name local-trusted rule 10 source address '10.1.2.5'
set firewall ipv4 name local-trusted rule 10 destination address '10.1.2.6'
set firewall ipv4 name local-trusted rule 20 action accept
set firewall ipv4 name local-trusted rule 20 protocol icmp
set firewall ipv4 name local-trusted rule 20 description 'Allow ICMP'
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
set firewall ipv4 name local-wan default-action 'drop'
set firewall ipv4 name local-wan default-log

# Allow both DHCP discovery broadcasts and unicast lease renewals.
set firewall ipv4 name local-wan rule 10 action 'accept'
set firewall ipv4 name local-wan rule 10 description 'WAN DHCP client'
set firewall ipv4 name local-wan rule 10 protocol 'udp'
set firewall ipv4 name local-wan rule 10 source port '68'
set firewall ipv4 name local-wan rule 10 destination port '67'

# Other services below may only use unicast destinations.
set firewall ipv4 name local-wan rule 20 action 'drop'
set firewall ipv4 name local-wan rule 20 description 'Block WAN multicast'
set firewall ipv4 name local-wan rule 20 destination address '224.0.0.0/4'
set firewall ipv4 name local-wan rule 21 action 'drop'
set firewall ipv4 name local-wan rule 21 description 'Block non-DHCP WAN broadcast'
set firewall ipv4 name local-wan rule 21 destination address '255.255.255.255'

set firewall ipv4 name local-wan rule 30 action 'accept'
set firewall ipv4 name local-wan rule 30 description 'DNS to configured resolver'
set firewall ipv4 name local-wan rule 30 protocol 'tcp_udp'
set firewall ipv4 name local-wan rule 30 destination address '1.1.1.1'
set firewall ipv4 name local-wan rule 30 destination port '53'

# Pool addresses and HTTPS CDN endpoints change; restrict their service ports.
set firewall ipv4 name local-wan rule 40 action 'accept'
set firewall ipv4 name local-wan rule 40 description 'NTP client'
set firewall ipv4 name local-wan rule 40 protocol 'udp'
set firewall ipv4 name local-wan rule 40 destination port '123'
set firewall ipv4 name local-wan rule 50 action 'accept'
set firewall ipv4 name local-wan rule 50 description 'HTTPS maintenance and DDNS'
set firewall ipv4 name local-wan rule 50 protocol 'tcp'
set firewall ipv4 name local-wan rule 50 destination port '443'

# Roaming WireGuard peers can use arbitrary destination ports.
set firewall ipv4 name local-wan rule 60 action 'accept'
set firewall ipv4 name local-wan rule 60 description 'WireGuard router socket'
set firewall ipv4 name local-wan rule 60 protocol 'udp'
set firewall ipv4 name local-wan rule 60 source port '51820'

icmp_rule=70
for icmp_type in echo-request echo-reply destination-unreachable time-exceeded parameter-problem; do
    set firewall ipv4 name local-wan rule "$icmp_rule" action 'accept'
    set firewall ipv4 name local-wan rule "$icmp_rule" description "ICMP $icmp_type"
    set firewall ipv4 name local-wan rule "$icmp_rule" protocol 'icmp'
    set firewall ipv4 name local-wan rule "$icmp_rule" icmp type-name "$icmp_type"
    icmp_rule=$((icmp_rule + 1))
done
unset icmp_rule icmp_type

# From LOCAL to TRANSIT
set firewall ipv4 name local-transit default-action 'drop'
set firewall ipv4 name local-transit default-log
set firewall ipv4 name local-transit rule 15 action 'accept'
set firewall ipv4 name local-transit rule 15 description 'Allow BGP to core'
set firewall ipv4 name local-transit rule 15 protocol 'tcp'
set firewall ipv4 name local-transit rule 15 source address '10.254.0.0'
set firewall ipv4 name local-transit rule 15 destination address '10.254.0.1'
set firewall ipv4 name local-transit rule 15 destination port '179'

# Allow ICMP for ping testing
set firewall ipv4 name local-transit rule 20 action accept
set firewall ipv4 name local-transit rule 20 protocol icmp
set firewall ipv4 name local-transit rule 20 description 'Allow ICMP'
