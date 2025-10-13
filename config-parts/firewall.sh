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
set firewall group address-group k8s_nodes address 10.254.1.1
set firewall group address-group k8s_nodes address 10.254.1.3
set firewall group address-group k8s_nodes address 10.254.1.5

# k8s pods
set firewall group network-group k8s_pods network '10.42.0.0/16'
set firewall group network-group k8s_pods network '172.20.0.0/16'

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

# Apple devices
set firewall group address-group airplay_targets address '10.1.3.14' # LGTV
set firewall group address-group airplay_sources address '10.1.2.11' # chris-macbook
set firewall group address-group airplay_sources address '10.1.2.14' # chris-macbook-lounge-dock

set firewall group port-group apple_services_ports port '3722'
set firewall group port-group apple_services_ports port '6002'
set firewall group port-group apple_services_ports port '7000'
set firewall group port-group apple_services_ports port '30000-65535'

# roon
set firewall group port-group roon_arc_ports port '59453'

set firewall group address-group node_exporter_targets address '10.1.2.54' # am6b
set firewall group address-group node_exporter_targets address '10.1.2.15' # gaming
set firewall group address-group node_exporter_targets address '10.1.1.31' # pve
set firewall group address-group node_exporter_targets address '10.1.1.41' # pve2
set firewall group address-group node_exporter_targets address '10.1.0.1' # gateway
set firewall group address-group node_exporter_targets address '10.1.1.155' # builer

set firewall group address-group STORAGE address 10.254.1.101

set firewall group address-group nfs_clients address 10.1.1.31
set firewall group address-group nfs_clients address 10.1.1.41

set firewall group port-group nfs_ports port 2049
set firewall group port-group nfs_ports port 111

# Network groups
set firewall group network-group L3_SERVERS network 10.254.1.0/24
set firewall group network-group POD_NETS network 172.20.0.0/16
set firewall group network-group LB_IPS network 10.45.0.0/24
set firewall group network-group DNS_SERVERS network 10.1.53.0/24

