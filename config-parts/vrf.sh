#!/bin/vbash

# VRF for VPN VLAN traffic that must only exit via wg02
set vrf name vpn-vlan description 'AirVPN client VRF'
set vrf name vpn-vlan table '100'
