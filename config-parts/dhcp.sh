#!/bin/vbash

# Global options
# matchbox
set service dhcp-server global-parameters 'option system-arch code 93 = unsigned integer 16;'

# Guest VLAN
set service dhcp-server shared-network-name GUEST authoritative
set service dhcp-server shared-network-name GUEST ping-check
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 default-router '192.168.2.1'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 lease '3600'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 range 0 start '192.168.2.200'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 range 0 stop '192.168.2.254'

set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 static-mapping chris-ably-laptop-eth ip-address '192.168.2.11'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 static-mapping chris-ably-laptop-eth mac-address '64:4b:f0:37:f6:78'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 static-mapping chris-ably-laptop-wifi ip-address '192.168.2.12'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 static-mapping chris-ably-laptop-wifi mac-address 'f8:4d:89:6c:71:db'

# IoT VLAN
set service dhcp-server shared-network-name IOT authoritative
set service dhcp-server shared-network-name IOT ping-check
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 default-router '10.1.3.1'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 domain-name 'cbannister.casa'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 lease '28800'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 range 0 start '10.1.3.200'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 range 0 stop '10.1.3.254'

set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping dyson-fan-office ip-address '10.1.3.11'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping dyson-fan-office mac-address 'c8:ff:77:e2:0f:98'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping bluray-player ip-address '10.1.3.12'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping bluray-player mac-address 'b4:6c:47:de:91:b9'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping sky-stream ip-address '10.1.3.13'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping sky-stream mac-address '04:b8:6a:4a:e5:47'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping lounge-tv ip-address '10.1.3.14'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping lounge-tv mac-address '58:fd:b1:69:d2:1b'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping fridge ip-address '10.1.3.15'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping fridge mac-address 'ac:f1:08:0d:d6:bd'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping lounge-shield ip-address '10.1.3.16'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping lounge-shield mac-address '48:b0:2d:2b:14:03'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping xbox-series-x ip-address '10.1.3.17'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping xbox-series-x mac-address '4c:3b:df:27:f4:00'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping lounge-harmony-hub ip-address '10.1.3.18'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping lounge-harmony-hub mac-address 'c8:db:26:10:c4:a7'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping office-printer ip-address '10.1.3.19'
set service dhcp-server shared-network-name IOT subnet 10.1.3.0/24 static-mapping office-printer mac-address 'd4:6a:6a:7c:40:86'

# LAN
set service dhcp-server shared-network-name LAN authoritative
set service dhcp-server shared-network-name LAN ping-check
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 default-router '10.1.0.1'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 lease '28800'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 ntp-server '10.1.0.1'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 range 0 start '10.1.0.200'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 range 0 stop '10.1.0.254'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 subnet-parameters 'option ubnt.unifi-controller 10.5.0.10;'

set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch-core ip-address '10.1.0.11'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch-core mac-address 'd8:b3:70:61:8a:a4'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch-lounge ip-address '10.1.0.12'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch-lounge mac-address '68:d7:9a:3e:4e:55'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch-agg ip-address '10.1.0.13'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping switch-agg mac-address 'f4:e2:c6:5f:78:1e'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap01 ip-address '10.1.0.21'
set service dhcp-server shared-network-name LAN subnet 10.1.0.0/24 static-mapping ap01 mac-address '78:45:58:9f:2c:04'

# Servers VLAN
set service dhcp-server shared-network-name SERVERS authoritative
set service dhcp-server shared-network-name SERVERS ping-check
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 default-router '10.1.1.1'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 domain-name 'cbannister.casa'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 lease '28800'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 ntp-server '10.1.1.1'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 range 0 start '10.1.1.200'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 range 0 stop '10.1.1.254'

set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters 'allow bootp;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters 'allow booting;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters 'next-server 10.1.1.1;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters 'if exists user-class and option user-class = &quot;iPXE&quot; {'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters 'filename &quot;http://10.5.0.8/boot.ipxe&quot;;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters '} else {'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters 'filename &quot;ipxe.efi&quot;;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 subnet-parameters '}'

set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-0 ip-address '10.1.1.10'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-0 mac-address 'ec:8e:b5:70:ca:20'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-0 static-mapping-parameters 'option host-name k8s-0;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-1 ip-address '10.1.1.11'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-1 mac-address '48:21:0b:60:1a:3f'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-1 static-mapping-parameters 'option host-name k8s-1;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-2 ip-address '10.1.1.12'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-2 mac-address 'ec:8e:b5:70:f6:59'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-2 static-mapping-parameters 'option host-name k8s-2;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-3 ip-address '10.1.1.13'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-3 mac-address 'f6:45:04:c6:96:e0'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-3 static-mapping-parameters 'option host-name k8s-3;'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-4 ip-address '10.1.1.14'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-4 mac-address '48:21:0b:56:ac:6c'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping k8s-4 static-mapping-parameters 'option host-name k8s-4;'

set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping pbj-ipmi ip-address '10.1.1.30'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping pbj-ipmi mac-address 'ac:1f:6b:e5:bb:5e'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping pbj ip-address '10.1.1.31'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping pbj mac-address 'ac:1f:6b:e5:be:42' # bond

# vms
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping nas ip-address '10.1.1.40'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping nas mac-address '2e:d2:2d:d2:34:cd'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping postgres ip-address '10.1.1.41'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping postgres mac-address '52:f0:87:82:1f:2c'


set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping pikvm ip-address '10.1.1.50'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping pikvm mac-address 'e4:5f:01:f4:9d:97'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping tesmart-kvm ip-address '10.1.1.51'
set service dhcp-server shared-network-name SERVERS subnet 10.1.1.0/24 static-mapping tesmart-kvm mac-address '38:3b:26:7f:32:12'

# Trusted VLAN
set service dhcp-server shared-network-name TRUSTED authoritative
set service dhcp-server shared-network-name TRUSTED ping-check
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 default-router '10.1.2.1'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 domain-name 'cbannister.casa'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 lease '28800'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 name-server '10.5.0.4'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 ntp-server '10.1.2.1'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 range 0 start '10.1.2.200'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 range 0 stop '10.1.2.254'

set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-iphone ip-address '10.1.2.10'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-iphone mac-address '6c:3a:ff:28:09:e1'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-macbook ip-address '10.1.2.11'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-macbook mac-address '3c:22:fb:d4:ac:17'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-watch ip-address '10.1.2.12'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-watch mac-address 'e8:81:52:3d:f7:cd'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-steam-deck ip-address '10.1.2.13'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping chris-steam-deck mac-address '14:D4:24:AE:D7:49'

set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-iphone ip-address '10.1.2.20'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-iphone mac-address '88:a4:79:ec:70:56'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-macbook ip-address '10.1.2.21'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-macbook mac-address 'bc:d0:74:32:06:e6'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-watch ip-address '10.1.2.22'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-watch mac-address 'd2:42:bf:f2:c5:26'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-ipad ip-address '10.1.2.23'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rocio-ipad mac-address 'b6:64:b5:1f:d4:a9'

set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping lounge-homepod ip-address '10.1.2.30'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping lounge-homepod mac-address 'd4:a3:3d:61:d4:76'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping office-homepod ip-address '10.1.2.31'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping office-homepod mac-address 'd4:a3:3d:6d:78:a2'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bedroom-homepod ip-address '10.1.2.32'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bedroom-homepod mac-address '58:d3:49:34:6c:6b'

set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping nvidia-shield ip-address '10.1.2.50'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping nvidia-shield mac-address '48:b0:2d:2b:14:03'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping blusound-flex-mini-office ip-address '10.1.2.52'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping blusound-flex-mini-office mac-address '90:56:82:61:1a:fb'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping mrx740 ip-address '10.1.2.53'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping mrx740 mac-address '50:1e:2d:3e:39:48'

# roon
# todo: move roon to IOT vlan and ensure it all works, need to forward ports and enable UDP Broadcast-Relay
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rock ip-address '10.1.2.60'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping rock mac-address '7e:7d:c6:c7:26:ac'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping ropiee ip-address '10.1.2.61'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping ropiee mac-address 'dc:a6:32:e9:d2:4b'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bluesound-node2i ip-address '10.1.2.63'
set service dhcp-server shared-network-name TRUSTED subnet 10.1.2.0/24 static-mapping bluesound-node2i mac-address '90:56:82:41:62:8e'
