# From TRANSIT to LOCAL
set firewall ipv4 name transit-local default-action 'drop'
set firewall ipv4 name transit-local default-log

set firewall ipv4 name transit-local rule 10 action accept
set firewall ipv4 name transit-local rule 10 protocol ospf
set firewall ipv4 name transit-local rule 10 description 'Allow OSPF'

set firewall ipv4 name transit-local rule 20 action accept
set firewall ipv4 name transit-local rule 20 protocol icmp
set firewall ipv4 name transit-local rule 20 description 'Allow ICMP'
