#!/bin/vbash

# needed to route traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface eth2

set protocols bgp neighbor 192.168.42.10 address-family ipv4-unicast
set protocols bgp neighbor 192.168.42.10 description 'k8s-0'
set protocols bgp neighbor 192.168.42.10 remote-as '64512'
set protocols bgp neighbor 192.168.42.11 address-family ipv4-unicast
set protocols bgp neighbor 192.168.42.11 description 'k8s-1'
set protocols bgp neighbor 192.168.42.11 remote-as '64512'
set protocols bgp neighbor 192.168.42.12 address-family ipv4-unicast
set protocols bgp neighbor 192.168.42.12 description 'k8s-2'
set protocols bgp neighbor 192.168.42.12 remote-as '64512'
set protocols bgp parameters router-id '10.1.0.1'
set protocols bgp system-as '64512'
