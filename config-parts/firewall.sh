#!/bin/vbash

# General configuration
set firewall global-options state-policy established action 'accept'
set firewall global-options state-policy related action 'accept'
set firewall global-options state-policy invalid action 'drop'
set firewall global-options state-policy invalid log
set firewall global-options all-ping enable
set firewall global-options broadcast-ping disable

# Router (VyOS itself)
set firewall group address-group router-addresses address 10.1.0.1
set firewall group address-group router-addresses address 127.0.0.1
set firewall group ipv6-address-group router-addresses-ipv6 address fe80::e63a:6eff:fe5a:f805
set firewall group ipv6-address-group router-addresses-ipv6 address ::1

# k8s nodes
set firewall group address-group k8s_nodes address '10.1.1.10-10.1.1.14' # Servers vLAN
