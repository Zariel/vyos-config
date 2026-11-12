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

# Permit gateway diagnostics and ICMP errors from the management subnet.
# Established replies are already accepted; redirects remain default-denied.
icmp_rule=20
for icmp_type in echo-request destination-unreachable time-exceeded parameter-problem; do
    set firewall ipv4 name lan-local rule "$icmp_rule" action 'accept'
    set firewall ipv4 name lan-local rule "$icmp_rule" description "Management ICMP $icmp_type"
    set firewall ipv4 name lan-local rule "$icmp_rule" protocol 'icmp'
    set firewall ipv4 name lan-local rule "$icmp_rule" source address '10.1.0.0/24'
    set firewall ipv4 name lan-local rule "$icmp_rule" icmp type-name "$icmp_type"
    icmp_rule=$((icmp_rule + 1))
done
unset icmp_rule icmp_type
set firewall ipv4 name lan-local rule 20 limit rate '10/second'
set firewall ipv4 name lan-local rule 20 limit burst '20'

set firewall ipv4 name lan-local rule 50 action 'accept'
set firewall ipv4 name lan-local rule 50 description 'Rule: accept_dhcp'
set firewall ipv4 name lan-local rule 50 destination port '67,68'
set firewall ipv4 name lan-local rule 50 protocol 'udp'
set firewall ipv4 name lan-local rule 50 source port '67,68'
set firewall ipv4 name lan-local rule 60 action 'accept'
set firewall ipv4 name lan-local rule 60 description 'Rule: accept_ntp'
set firewall ipv4 name lan-local rule 60 destination port 'ntp'
set firewall ipv4 name lan-local rule 60 destination address 10.254.254.1
set firewall ipv4 name lan-local rule 60 protocol 'udp'
set firewall ipv4 name lan-local rule 80 action 'accept'
set firewall ipv4 name lan-local rule 80 description 'Rule: accept_tftp'
set firewall ipv4 name lan-local rule 80 destination port '69'
set firewall ipv4 name lan-local rule 80 protocol 'udp'
set firewall ipv4 name lan-local rule 100 action 'accept'
set firewall ipv4 name lan-local rule 100 description 'Rule: accept_node_exporter_from_k8s_pods'
set firewall ipv4 name lan-local rule 100 destination port '9100'
set firewall ipv4 name lan-local rule 100 protocol 'tcp'
set firewall ipv4 name lan-local rule 100 source group network-group 'k8s_pods'
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

set firewall ipv4 name lan-transit rule 10 action accept
set firewall ipv4 name lan-transit rule 10 description 'Allow access to DNS'
set firewall ipv4 name lan-transit rule 10 destination port '53'
set firewall ipv4 name lan-transit rule 10 destination group address-group 'DNS_VIPS'
set firewall ipv4 name lan-transit rule 10 protocol 'tcp_udp'

set firewall ipv4 name lan-trusted rule 100 action 'accept'
set firewall ipv4 name lan-trusted rule 100 description 'Rule: allow sflow'
set firewall ipv4 name lan-trusted rule 100 destination port '6343'
set firewall ipv4 name lan-trusted rule 100 destination address 10.1.2.14
set firewall ipv4 name lan-trusted rule 100 protocol 'udp'

# From LAN to WAN
set firewall ipv4 name lan-wan default-action 'accept'
