# From TRANSIT to LOCAL
set firewall ipv4 name transit-local default-action 'drop'
set firewall ipv4 name transit-local default-log

set firewall ipv4 name transit-local rule 10 action accept
set firewall ipv4 name transit-local rule 10 protocol ospf
set firewall ipv4 name transit-local rule 10 description 'Allow OSPF'

set firewall ipv4 name transit-local rule 20 action accept
set firewall ipv4 name transit-local rule 20 protocol icmp
set firewall ipv4 name transit-local rule 20 description 'Allow ICMP'

set firewall ipv4 name transit-local rule 30 action accept
set firewall ipv4 name transit-local rule 30 description 'Allow NTP'
set firewall ipv4 name transit-local rule 30 destination port 123
set firewall ipv4 name transit-local rule 30 protocol udp

set firewall ipv4 name transit-local rule 110 action accept
set firewall ipv4 name transit-local rule 110 description 'Allow access to node_exporter'
set firewall ipv4 name transit-local rule 110 destination port 9100
set firewall ipv4 name transit-local rule 110 source group network-group POD_NETS
set firewall ipv4 name transit-local rule 110 protocol tcp
set firewall ipv4 name transit-local rule 110 destination group address-group node_exporter_targets

# From TRANSIT to CONTAINERS
set firewall ipv4 name transit-containers rule 10 action accept
set firewall ipv4 name transit-containers rule 10 description 'Allow DNS'
set firewall ipv4 name transit-containers rule 10 destination port 53
set firewall ipv4 name transit-containers rule 10 destination address 10.5.0.4
set firewall ipv4 name transit-containers rule 10 protocol tcp_udp

set firewall ipv4 name transit-containers rule 100 action accept
set firewall ipv4 name transit-containers rule 100 description 'Allow access to haproxy k8s control plane'
set firewall ipv4 name transit-containers rule 100 destination port 6443,50000
set firewall ipv4 name transit-containers rule 100 destination address 10.5.0.2
set firewall ipv4 name transit-containers rule 100 source group address-group k8s_nodes
set firewall ipv4 name transit-containers rule 100 protocol tcp

set firewall ipv4 name transit-containers rule 110 action accept
set firewall ipv4 name transit-containers rule 110 description 'Allow access to scrape dnsdist'
set firewall ipv4 name transit-containers rule 110 destination port 8083
set firewall ipv4 name transit-containers rule 110 destination address 10.5.0.4
set firewall ipv4 name transit-containers rule 110 source group network-group POD_NODES
set firewall ipv4 name transit-containers rule 110 protocol tcp

set firewall ipv4 name transit-containers rule 120 action accept
set firewall ipv4 name transit-containers rule 120 description 'Allow access to scrape blocky'
set firewall ipv4 name transit-containers rule 120 destination port 4000
set firewall ipv4 name transit-containers rule 120 destination address 10.5.0.7
set firewall ipv4 name transit-containers rule 120 source group network-group POD_NODES
set firewall ipv4 name transit-containers rule 120 protocol tcp

# From TRANSIT to WAN
set firewall ipv4 name transit-wan default-action drop
set firewall ipv4 name transit-wan rule 100 action accept
set firewall ipv4 name transit-wan rule 100 description 'Allow K8S to access WAN'
set firewall ipv4 name transit-wan rule 100 source group address-group k8s_nodes

set firewall ipv4 name transit-wan rule 110 action accept
set firewall ipv4 name transit-wan rule 110 description 'Allow truenas to access HTTP'
set firewall ipv4 name transit-wan rule 110 source group address-group STORAGE
set firewall ipv4 name transit-wan rule 110 destination port 80,443
set firewall ipv4 name transit-wan rule 110 protocol tcp

set firewall ipv4 name transit-wan rule 120 action accept
set firewall ipv4 name transit-wan rule 120 description 'Allow pods to access internet'
set firewall ipv4 name transit-wan rule 120 source group network-group POD_NETS


# From TRANSIT to TRUSTED
set firewall ipv4 name transit-trusted default-action drop
set firewall ipv4 name transit-trusted rule 100 action accept
set firewall ipv4 name transit-trusted rule 100 description 'Allow access to node_exporter and smartctl_exporter'
set firewall ipv4 name transit-trusted rule 100 source group network-group POD_NETS
set firewall ipv4 name transit-trusted rule 100 destination port 9100,9633
set firewall ipv4 name transit-trusted rule 100 destination group address-group node_exporter_targets
set firewall ipv4 name transit-trusted rule 100 protocol tcp

# From TRANSIT to IOT
set firewall ipv4 name transit-iot default-action drop

# From TRANSIT to SERVERS
set firewall ipv4 name transit-servers default-action drop
set firewall ipv4 name transit-servers rule 100 action accept
set firewall ipv4 name transit-servers rule 100 description 'Allow access to node_exporter and smartctl_exporter'
set firewall ipv4 name transit-servers rule 100 source group network-group POD_NETS
set firewall ipv4 name transit-servers rule 100 destination port 9100,9633
set firewall ipv4 name transit-servers rule 100 destination group address-group node_exporter_targets
set firewall ipv4 name transit-servers rule 100 protocol tcp
