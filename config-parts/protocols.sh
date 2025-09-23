#!/bin/vbash

# needed to route traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface bond0.99

set protocols bgp peer-group k8s graceful-restart enable
set protocols bgp peer-group k8s remote-as '64513'
set protocols bgp peer-group k8s address-family ipv4-unicast

set protocols bgp neighbor 10.1.1.10 description 'k8s-0'
set protocols bgp neighbor 10.1.1.10 peer-group k8s

set protocols bgp neighbor 10.1.1.11 description 'k8s-1'
set protocols bgp neighbor 10.1.1.11 peer-group k8s

set protocols bgp neighbor 10.1.1.12 description 'k8s-2'
set protocols bgp neighbor 10.1.1.12 peer-group k8s

set protocols bgp parameters router-id '10.1.0.1'
set protocols bgp system-as '64512'

set protocols ospf interface bond0.5 area 0
set protocols ospf interface bond0.5 network point-to-point
set protocols ospf interface bond0.5 dead-interval 40
set protocols ospf interface bond0.5 hello-interval 10
set protocols ospf interface bond0.5 priority 1
set protocols ospf log-adjacency-changes detail
set protocols ospf parameters router-id '10.1.0.1'
