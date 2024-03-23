#!/bin/vbash

set firewall zone guest default-action 'drop'
set firewall zone guest from iot firewall name 'iot-guest'
set firewall zone guest from lan firewall name 'lan-guest'
set firewall zone guest from local firewall name 'local-guest'
set firewall zone guest from servers firewall name 'servers-guest'
set firewall zone guest from containers firewall name 'containers-guest'
set firewall zone guest from trusted firewall name 'trusted-guest'
set firewall zone guest from wan firewall name 'wan-guest'
set firewall zone guest interface 'bond0.30'

set firewall zone iot default-action 'drop'
set firewall zone iot from guest firewall name 'guest-iot'
set firewall zone iot from lan firewall name 'lan-iot'
set firewall zone iot from local firewall name 'local-iot'
set firewall zone iot from servers firewall name 'servers-iot'
set firewall zone iot from containers firewall name 'containers-iot'
set firewall zone iot from trusted firewall name 'trusted-iot'
set firewall zone iot from wan firewall name 'wan-iot'
set firewall zone iot interface 'bond0.40'

set firewall zone lan default-action 'drop'
set firewall zone lan from guest firewall name 'guest-lan'
set firewall zone lan from iot firewall name 'iot-lan'
set firewall zone lan from local firewall name 'local-lan'
set firewall zone lan from servers firewall name 'servers-lan'
set firewall zone lan from containers firewall name 'containers-lan'
set firewall zone lan from trusted firewall name 'trusted-lan'
set firewall zone lan from wan firewall name 'wan-lan'
set firewall zone lan interface 'bond0'

set firewall zone local default-action 'drop'
set firewall zone local description 'Local router zone'
set firewall zone local from guest firewall name 'guest-local'
set firewall zone local from iot firewall name 'iot-local'
set firewall zone local from lan firewall name 'lan-local'
set firewall zone local from servers firewall name 'servers-local'
set firewall zone local from containers firewall name 'containers-local'
set firewall zone local from trusted firewall name 'trusted-local'
set firewall zone local from wan firewall name 'wan-local'
set firewall zone local local-zone

set firewall zone servers default-action 'drop'
set firewall zone servers from guest firewall name 'guest-servers'
set firewall zone servers from iot firewall name 'iot-servers'
set firewall zone servers from lan firewall name 'lan-servers'
set firewall zone servers from local firewall name 'local-servers'
set firewall zone servers from containers firewall name 'containers-servers'
set firewall zone servers from trusted firewall name 'trusted-servers'
set firewall zone servers from wan firewall name 'wan-servers'
set firewall zone servers interface 'bond0.10'

set firewall zone containers default-action 'drop'
set firewall zone containers description 'VyOS containers zone'
set firewall zone containers from guest firewall name 'guest-containers'
set firewall zone containers from iot firewall name 'iot-containers'
set firewall zone containers from lan firewall name 'lan-containers'
set firewall zone containers from local firewall name 'local-containers'
set firewall zone containers from servers firewall name 'servers-containers'
set firewall zone containers from trusted firewall name 'trusted-containers'
set firewall zone containers from wan firewall name 'wan-containers'
set firewall zone containers interface 'pod-containers'

set firewall zone trusted default-action 'drop'
set firewall zone trusted from guest firewall name 'guest-trusted'
set firewall zone trusted from iot firewall name 'iot-trusted'
set firewall zone trusted from lan firewall name 'lan-trusted'
set firewall zone trusted from local firewall name 'local-trusted'
set firewall zone trusted from servers firewall name 'servers-trusted'
set firewall zone trusted from containers firewall name 'containers-trusted'
set firewall zone trusted from wan firewall name 'wan-trusted'
set firewall zone trusted interface 'bond0.20'

set firewall zone wan default-action 'drop'
set firewall zone wan from guest firewall name 'guest-wan'
set firewall zone wan from iot firewall name 'iot-wan'
set firewall zone wan from lan firewall name 'lan-wan'
set firewall zone wan from local firewall name 'local-wan'
set firewall zone wan from servers firewall name 'servers-wan'
set firewall zone wan from containers firewall name 'containers-wan'
set firewall zone wan from trusted firewall name 'trusted-wan'
set firewall zone wan interface 'eth2'
