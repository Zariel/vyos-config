#!/bin/vbash

# From LOCAL to WAN
set firewall ipv6 name local-wan default-action 'accept'
set firewall ipv6 name local-wan description 'From LOCAL to WAN'
