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

# From TRANSIT to CONTAINER
set firewall ipv4 name transit-container rule 10 action accept
set firewall ipv4 name transit-container rule 10 description 'Allow DNS'
set firewall ipv4 name transit-container rule 10 destination port 53
set firewall ipv4 name transit-container rule 10 protocol tcp_udp

# From TRANSIT to WAN
set firewall ipv4 name transit-wan default-action drop
set firewall ipv4 name transit-wan rule 100 action accept
set firewall ipv4 name transit-wan rule 100 description 'Allow K8S to access HTTP'
set firewall ipv4 name transit-wan rule 100 source address-group PROD_K8S
set firewall ipv4 name transit-wan rule 100 destination port 80,443

set firewall ipv4 name transit-wan rule 110 action accept
set firewall ipv4 name transit-wan rule 110 description 'Allow truenas to access HTTP'
set firewall ipv4 name transit-wan rule 110 source address-group STORAGE
set firewall ipv4 name transit-wan rule 110 destination port 80,443

set firewall ipv4 name transit-wan rule 120 action accept
set firewall ipv4 name transit-wan rule 120 description 'Allow pods to access internet'
set firewall ipv4 name transit-wan rule 120 source network-group POD_NETS


# From TRANSIT to TRUSTED
set firewall ipv4 name transit-trusted default-action drop

# From TRANSIT to IOT
set firewall ipv4 name transit-iot default-action drop
