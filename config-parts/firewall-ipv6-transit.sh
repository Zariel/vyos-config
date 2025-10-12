# From TRANSIT to LOCAL
set firewall ipv6 name transit-local default-action 'accept'
set firewall ipv6 name transit-local default-log

set firewall ipv6 name transit-local rule 10 action accept
set firewall ipv6 name transit-local rule 10 protocol ospf
set firewall ipv6 name transit-local rule 10 description 'Allow OSPF'
