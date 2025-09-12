#!/bin/vbash

for to in guest iot lan local servers containers trusted wan; do
    set firewall zone $to default-action 'drop'
    for from in guest iot lan local servers containers trusted wan; do
        if [ "$from" == "$to" ]; then
            continue
        fi
        set firewall zone $to from $from firewall name "${from}-${to}"
        set firewall zone $to from $from firewall ipv6-name "${from}-${to}"

        set firewall ipv4 name $from-$to description "From ${from^^} to ${to^^}"
        set firewall ipv4 name $from-$to rule 1 action 'accept'
        set firewall ipv4 name $from-$to rule 1 description 'Rule: allow_related_established'
        set firewall ipv4 name $from-$to rule 1 state related
        set firewall ipv4 name $from-$to rule 1 state established
        set firewall ipv4 name $from-$to rule 999 action 'drop'
        set firewall ipv4 name $from-$to rule 999 description 'Rule: drop_invalid'
        set firewall ipv4 name $from-$to rule 999 state invalid
        set firewall ipv4 name $from-$to rule 999 log

        set firewall ipv6 name $from-$to description "From ${from^^} to ${to^^}"
        set firewall ipv6 name $from-$to rule 1 action 'accept'
        set firewall ipv6 name $from-$to rule 1 description 'Rule: allow_related_established'
        set firewall ipv6 name $from-$to rule 1 state related
        set firewall ipv6 name $from-$to rule 1 state established
        set firewall ipv6 name $from-$to rule 999 action 'drop'
        set firewall ipv6 name $from-$to rule 999 description 'Rule: drop_invalid'
        set firewall ipv6 name $from-$to rule 999 state invalid
        set firewall ipv6 name $from-$to rule 999 log
  done
done

set firewall zone wan interface 'eth2'
set firewall zone wan interface 'bond0.99'
set firewall zone lan interface 'bond0'
set firewall zone servers interface 'bond0.10'
set firewall zone trusted interface 'bond0.20'
set firewall zone trusted interface 'wg01'
set firewall zone guest interface 'bond0.30'
set firewall zone iot interface 'bond0.40'
set firewall zone video interface 'bind0.50'
set firewall zone containers interface 'pod-containers'
set firewall zone local local-zone
