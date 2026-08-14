#!/bin/vbash

# needed to route traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface eth3

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
set protocols ospf interface bond0.3001 area '0'
set protocols ospf interface bond0.3001 dead-interval '40'
set protocols ospf interface bond0.3001 hello-interval '10'
set protocols ospf interface bond0.3001 network 'point-to-point'
set protocols ospf redistribute connected metric '10' route-map 'OSPF-CONNECTED'
set protocols ospf redistribute connected route-map 'OSPF-CONNECTED'
set protocols ospf redistribute static metric '10'
set protocols ospf log-adjacency-changes detail
set protocols ospf parameters router-id '10.254.254.65'

set protocols ospfv3 parameters router-id 10.254.254.65
set protocols ospfv3 interface bond0.3001 area 0
set protocols ospfv3 interface bond0.3001 network 'point-to-point'
set protocols ospfv3 redistribute connected

# igmp ipv4 multicast, vyos is querier
set protocols pim interface bond0.20 igmp version 2
set protocols pim interface bond0.20 igmp query-interval 125
set protocols pim interface bond0.20 igmp query-max-response-time 10
set protocols pim interface bond0.40 igmp version 2
set protocols pim interface bond0.40 igmp query-interval 125
set protocols pim interface bond0.40 igmp query-max-response-time 10

# igmp ipv6 multicast, vyos is querier
set protocols pim6 interface bond0.20 mld version 2
set protocols pim6 interface bond0.20 mld interval 125
# bug in vyos 1.4 cant set this
# set protocols pim6 interface bond0.20 mld max-response-time 10000
set protocols pim6 interface bond0.40 mld version 2
set protocols pim6 interface bond0.40 mld interval 125
# set protocols pim6 interface bond0.40 mld max-response-time 10000

# Route to thread devices via otbr
set protocols static route6 fd42:dfb5:24e4:1::/64 next-hop fd74:f571:d3bd:40:41d7:bb2e:6c90:a8f5
