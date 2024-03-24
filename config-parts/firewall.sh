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
set firewall group address-group k8s_nodes address '10.1.1.10-10.1.1.14' # Servers vlan

set firewall group address-group plex_clients address '10.1.3.16' # lounge-shield

# k8s things
set firewall group address-group k8s_plex address '10.45.0.20'
set firewall group port-group k8s_plex_ports port '32400'
set firewall group address-group k8s_jellyfin address '10.45.0.21'
set firewall group port-group k8s_jellyfin_ports port '8096'
set firewall group port-group k8s_jellyfin_ports port '1900'
set firewall group port-group k8s_jellyfin_ports port '7359'

set firewall group address-group k8s_ingress address '10.45.0.10'
set firewall group port-group k8s_ingress port '443'

set firewall group address-group k8s_ingress_clients address '10.1.3.16'
