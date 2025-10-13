#!/bin/vbash

# needed to route traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface bond0.99

set protocols static route 10.0.0.0/8 reject

set protocols ospf default-information originate always
set protocols ospf default-information originate metric '1'
set protocols ospf default-information originate metric-type '2'
set protocols ospf interface bond0.5 area '0'
set protocols ospf interface bond0.5 dead-interval '40'
set protocols ospf interface bond0.5 hello-interval '10'
set protocols ospf interface bond0.5 network 'point-to-point'
set protocols ospf interface bond0.5 priority '1'
set protocols ospf redistribute connected metric '10'
set protocols ospf redistribute static metric '10'
set protocols ospf log-adjacency-changes detail
set protocols ospf parameters router-id '10.1.0.1'

set protocols ospfv3 parameters router-id 10.1.0.1
set protocols ospfv3 interface bond0.5 area 0
set protocols ospfv3 interface bond0.5 network 'point-to-point'
set protocols ospfv3 redistribute connected
