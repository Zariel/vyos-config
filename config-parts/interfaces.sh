#!/bin/vbash

# set interfaces ethernet eth0 description 'LAN0'
set interfaces ethernet eth0 hw-id '08:c0:eb:0f:e4:30'
delete interfaces ethernet eth0 address

# set interfaces ethernet eth1 description 'LAN1'
set interfaces ethernet eth1 hw-id '08:c0:eb:0f:e4:31'
delete interfaces ethernet eth1 address

set interfaces bonding bond0 description 'LAN'
set interfaces bonding bond0 address '10.1.0.1/24'
set interfaces bonding bond0 member interface eth0
set interfaces bonding bond0 member interface eth1
set interfaces bonding bond0 mode '802.3ad'
set interfaces bonding bond0 hash-policy 'layer3+4'

set interfaces bonding bond0 address '10.1.0.1/24'
set interfaces bonding bond0 vif 10 address '10.1.1.1/24'
set interfaces bonding bond0 vif 10 description 'SERVERS'
set interfaces bonding bond0 vif 20 address '10.1.2.1/24'
set interfaces bonding bond0 vif 20 description 'TRUSTED'
set interfaces bonding bond0 vif 30 address '192.168.1.1/24'
set interfaces bonding bond0 vif 30 description 'GUEST'
set interfaces bonding bond0 vif 40 address '10.1.3.1/24'
set interfaces bonding bond0 vif 40 description 'IOT'

# legacy network
set interfaces bonding bond0 vif 42 address '192.168.42.1/24'
set interfaces bonding bond0 vif 42 description 'k8s'

set interfaces ethernet eth2 hw-id 'a0:36:9f:a9:0d:3a'
set interfaces ethernet eth2 description 'WAN'
set interfaces ethernet eth2 address 'dhcp'
# TODO: ipv6 prefix delegation
# set interfaces ethernet eth2 mtu '1500'

set interfaces ethernet eth3 hw-id 'a0:36:9f:a9:0d:3b'
set interfaces ethernet eth4 hw-id '50:9a:4c:4b:f6:0c'
