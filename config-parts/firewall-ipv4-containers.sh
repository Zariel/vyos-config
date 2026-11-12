#!/bin/vbash

# Matchbox serves local PXE assets and needs no outbound sessions. Node exporter
# uses host networking and is governed by the local zone. Established/related
# rules in firewall-zones.sh allow replies to permitted inbound requests.

# From CONTAINERS to GUEST
set firewall ipv4 name containers-guest default-action 'drop'
set firewall ipv4 name containers-guest default-log

# From CONTAINERS to IOT
set firewall ipv4 name containers-iot default-action 'drop'
set firewall ipv4 name containers-iot default-log

# From CONTAINERS to LAN
set firewall ipv4 name containers-lan default-action 'drop'
set firewall ipv4 name containers-lan default-log

# From CONTAINERS to LOCAL
set firewall ipv4 name containers-local default-action 'drop'
set firewall ipv4 name containers-local default-log

# From CONTAINERS to SERVERS
set firewall ipv4 name containers-servers default-action 'drop'

# From CONTAINERS to TRUSTED
set firewall ipv4 name containers-trusted default-action 'drop'
set firewall ipv4 name containers-trusted default-log

# From CONTAINERS to WAN
set firewall ipv4 name containers-wan default-action 'drop'

# From CONTAINERS to TRANSIT
set firewall ipv4 name containers-transit default-action 'drop'
