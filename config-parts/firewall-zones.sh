#!/bin/vbash

for to in guest iot lan local servers containers trusted wan; do
    set firewall zone $to default-action 'drop'
    for from in guest iot lan local servers containers trusted wan; do
        if [ "$from" == "$to" ]; then
            continue
        fi
        set firewall zone $to from $from firewall name "${from}-${to}"
        set firewall zone $to from $from firewall ipv6-name "${from}-${to}"
  done
done

set firewall zone wan interface 'eth2'
set firewall zone lan interface 'bond0'
set firewall zone servers interface 'bond0.10'
set firewall zone trusted interface 'bond0.20'
set firewall zone guest interface 'bond0.30'
set firewall zone iot interface 'bond0.40'
set firewall zone containers interface 'pod-containers'
set firewall zone local local-zone
