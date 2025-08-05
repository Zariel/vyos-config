#!/bin/vbash

# needed to route traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface eth2

set protocols bgp peer-group k8s graceful-restart enable
set protocols bgp peer-group k8s remote-as '64513'
set protocols bgp peer-group k8s address-family ipv4-unicast

set protocols bgp neighbor 10.1.8.10 description 'k8s-0'
set protocols bgp neighbor 10.1.8.10 peer-group k8s

set protocols bgp neighbor 10.1.8.11 description 'k8s-1'
set protocols bgp neighbor 10.1.8.11 peer-group k8s

set protocols bgp neighbor 10.1.8.12 description 'k8s-2'
set protocols bgp neighbor 10.1.8.12 peer-group k8s

set protocols bgp neighbor 10.1.8.13 description 'k8s-3'
set protocols bgp neighbor 10.1.8.13 peer-group k8s

set protocols bgp parameters router-id '10.1.0.1'
set protocols bgp system-as '64512'
