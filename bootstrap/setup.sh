#!/bin/bash

load /opt/vyatta/etc/config.boot.default

# set interfaces ethernet eth0 description 'MGMT'
# TODO: set this as a static IP as it would be nice to SSH to it
# set interfaces ethernet eth0 address dhcp
# set interfaces ethernet eth0 hw-id '50:9a:4c:4b:f6:0c'

set system login user vyos authentication public-keys personal key 'AAAAC3NzaC1lZDI1NTE5AAAAINiFPVXT03FdYS3BKuqNmgplaGrzNc6i++77vCI2AJ8c'
set system login user vyos authentication public-keys personal type 'ssh-ed25519'

set service ssh disable-password-authentication
set service ssh port '22'

delete system host-name
set system host-name 'gateway'
set system domain-name 'cbannister.casa'

set system static-host-mapping host-name gateway inet '10.1.0.1'

set system name-server '1.1.1.1'

set system ipv6 disable-forwarding

set system time-zone 'Europe/London'

set interfaces ethernet eth0 description 'LAN0'
set interfaces ethernet eth0 hw-id '08:c0:eb:0f:e4:30'
set interfaces ethernet eth0 address '10.1.0.1/24'

set interfaces ethernet eth1 description 'LAN1'
set interfaces ethernet eth1 hw-id '08:c0:eb:0f:e4:31'

set interfaces ethernet eth2 hw-id 'a0:36:9f:a9:0d:3a'
set interfaces ethernet eth2 description 'WAN'
set interfaces ethernet eth2 address 'dhcp'

set interfaces ethernet eth3 hw-id 'a0:36:9f:a9:0d:3b'

set interfaces ethernet eth4 hw-id '50:9a:4c:4b:f6:0c'
set interfaces ethernet eth4 description 'MGMT'
set interfaces ethernet eth4 address 'dhcp'

set service dhcp-server shared-network-name LAN authoritative
set service dhcp-server shared-network-name LAN ping-check
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 default-router '10.1.0.1'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 range 0 start '10.1.0.200'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 range 0 stop '10.1.0.254'

# ALL -> WAN masquerade
set nat source rule 100 description 'LAN -> WAN'
set nat source rule 100 outbound-interface name 'eth2'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 translation address 'masquerade'

# Route all traffic to WAN
set protocols static route 0.0.0.0/0 dhcp-interface eth2
