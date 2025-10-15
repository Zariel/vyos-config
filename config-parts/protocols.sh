#!/bin/vbash

# needed to route traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface bond0.99

set protocols static route 10.0.0.0/8 reject

# Prefix list to only allow private networks in OSPF
set policy prefix-list OSPF-CONNECTED-ALLOW rule 10 action 'permit'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 10 prefix '10.0.0.0/8'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 10 le '32'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 20 action 'permit'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 20 prefix '172.16.0.0/12'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 20 le '32'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 30 action 'permit'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 30 prefix '192.168.0.0/16'
set policy prefix-list OSPF-CONNECTED-ALLOW rule 30 le '32'

# Route map to apply prefix list
set policy route-map OSPF-CONNECTED rule 10 action 'permit'
set policy route-map OSPF-CONNECTED rule 10 match ip address prefix-list 'OSPF-CONNECTED-ALLOW'

set protocols ospf default-information originate always
set protocols ospf default-information originate metric '1'
set protocols ospf default-information originate metric-type '2'
set protocols ospf interface bond0.5 area '0'
set protocols ospf interface bond0.5 dead-interval '40'
set protocols ospf interface bond0.5 hello-interval '10'
set protocols ospf interface bond0.5 network 'point-to-point'
set protocols ospf interface bond0.5 priority '1'
set protocols ospf redistribute connected metric '10' route-map 'OSPF-CONNECTED'
set protocols ospf redistribute connected route-map 'OSPF-CONNECTED'
set protocols ospf redistribute static metric '10'
set protocols ospf log-adjacency-changes detail
set protocols ospf parameters router-id '10.1.0.1'

set protocols ospfv3 parameters router-id 10.1.0.1
set protocols ospfv3 interface bond0.5 area 0
set protocols ospfv3 interface bond0.5 network 'point-to-point'
set protocols ospfv3 redistribute connected
