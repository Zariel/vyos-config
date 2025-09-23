#!/bin/vbash

set interfaces ethernet eth0 description 'LAN0'
set interfaces ethernet eth0 hw-id '08:c0:eb:0f:e4:30'
set interfaces ethernet eth0 offload gro
set interfaces ethernet eth0 offload gso
set interfaces ethernet eth0 offload rfs
set interfaces ethernet eth0 offload rps
set interfaces ethernet eth0 offload sg
set interfaces ethernet eth0 offload tso
set interfaces ethernet eth0 ring-buffer rx '8192'
set interfaces ethernet eth0 ring-buffer tx '8192'

delete interfaces ethernet eth0 address

set interfaces ethernet eth1 description 'LAN1'
set interfaces ethernet eth1 hw-id '08:c0:eb:0f:e4:31'
set interfaces ethernet eth1 offload gro
set interfaces ethernet eth1 offload gso
set interfaces ethernet eth1 offload rfs
set interfaces ethernet eth1 offload rps
set interfaces ethernet eth1 offload sg
set interfaces ethernet eth1 offload tso
set interfaces ethernet eth1 ring-buffer rx '8192'
set interfaces ethernet eth1 ring-buffer tx '8192'

delete interfaces ethernet eth1 address

set interfaces bonding bond0 description 'LAN'
set interfaces bonding bond0 mode '802.3ad'
set interfaces bonding bond0 hash-policy 'layer3+4'
set interfaces bonding bond0 lacp-rate 'fast'
set interfaces bonding bond0 mac '08:c0:eb:0f:e4:30'
set interfaces bonding bond0 mtu 9000

set interfaces bonding bond0 vif 5 address 10.254.255.0/31
set interfaces bonding bond0 vif 5 description 'TRANSIT'
set interfaces bonding bond0 vif 5 mtu 9000

set interfaces bonding bond0 vif 10 address '10.1.1.1/24'
set interfaces bonding bond0 vif 10 description 'SERVERS'
set interfaces bonding bond0 vif 10 mtu 9000

set interfaces bonding bond0 vif 20 address '10.1.2.1/24'
set interfaces bonding bond0 vif 20 address 'fd74:f571:d3bd:20::1/64'
set interfaces bonding bond0 vif 20 description 'TRUSTED'
set interfaces bonding bond0 vif 20 mtu 1500

set interfaces bonding bond0 vif 30 address '192.168.2.1/24'
set interfaces bonding bond0 vif 30 description 'GUEST'
set interfaces bonding bond0 vif 30 mtu 1500

set interfaces bonding bond0 vif 40 address '10.1.3.1/24'
set interfaces bonding bond0 vif 40 address 'fd74:f571:d3bd:40::1/64'
set interfaces bonding bond0 vif 40 description 'IOT'
set interfaces bonding bond0 vif 40 mtu 1500

set interfaces bonding bond0 vif 50 address '10.1.5.1/24'
set interfaces bonding bond0 vif 50 description 'UNIFI'
set interfaces bonding bond0 vif 50 mtu 1500

set interfaces bonding bond0 vif 99 address 'dhcp'
set interfaces bonding bond0 vif 99 description 'WAN'
set interfaces bonding bond0 vif 99 mtu 1500
set interfaces bonding bond0 vif 99 ipv6 address autoconf
set interfaces bonding bond0 vif 99 dhcpv6-options pd 0 length 56
set interfaces bonding bond0 vif 99 dhcpv6-options pd 0 interface bond0.20 sla-id 20
set interfaces bonding bond0 vif 99 dhcpv6-options pd 0 interface bond0.20 address 1
set interfaces bonding bond0 vif 99 dhcpv6-options pd 0 interface bond0.40 sla-id 40
set interfaces bonding bond0 vif 99 dhcpv6-options pd 0 interface bond0.40 address 1

set interfaces bonding bond0 member interface eth0
set interfaces bonding bond0 member interface eth1
set interfaces bonding bond0 address '10.1.0.1/24'

set interfaces ethernet eth2 hw-id 'a0:36:9f:a9:0d:3a'

# TODO: ipv6 prefix delegation
# set interfaces ethernet eth2 mtu '1500'

set interfaces ethernet eth3 hw-id 'a0:36:9f:a9:0d:3b'

set interfaces ethernet eth4 hw-id '50:9a:4c:4b:f6:0c'
set interfaces ethernet eth4 description 'MGMT'
set interfaces ethernet eth4 address '10.1.0.1/24'

set interfaces wireguard wg01 address '10.0.11.1/24'
set interfaces wireguard wg01 description 'WIREGUARD'
set interfaces wireguard wg01 peer wall-e allowed-ips '10.0.11.4/32'
set interfaces wireguard wg01 peer wall-e persistent-keepalive '15'
set interfaces wireguard wg01 peer wall-e public-key '0wrH9QqKMRbcnMc41xzwEvLX9xyKY/mB1no94woOAhQ='
set interfaces wireguard wg01 peer chris-macbook allowed-ips '10.0.11.5/32'
set interfaces wireguard wg01 peer chris-macbook public-key 'YDJXbNWbwqA7ipjuVaBrR83Yp6DXocojiFigEIUJnVk='
set interfaces wireguard wg01 peer chris-macbook persistent-keepalive '15'
set interfaces wireguard wg01 peer chris-iphone allowed-ips '10.0.11.6/32'
set interfaces wireguard wg01 peer chris-iphone public-key '8GJVX0GvW7BE8n+G1+Be/IlvJx5rMQyno5bG8iIK1EY='
set interfaces wireguard wg01 peer chris-iphone persistent-keepalive '15'
set interfaces wireguard wg01 port '51820'
set interfaces wireguard wg01 private-key "${SECRET_WIREGUARD_PRIVATE_KEY}"
