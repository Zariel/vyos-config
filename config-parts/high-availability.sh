#!/bin/vbash

# Trusted IPv4 gateway: VyOS .5/32, backup VM .6/32, shared gateway .1/24.
# Keep the VIP on bond0.20 so the existing zone and NAT interface matches apply.
set high-availability vrrp group TRUSTED description 'Trusted gateway migration failover'
set high-availability vrrp group TRUSTED interface 'bond0.20'
set high-availability vrrp group TRUSTED address '10.1.2.1/24'
set high-availability vrrp group TRUSTED vrid '20'
set high-availability vrrp group TRUSTED priority '200'
set high-availability vrrp group TRUSTED advertise-interval '1'
set high-availability vrrp group TRUSTED no-preempt
set high-availability vrrp group TRUSTED hello-source-address '10.1.2.5'
set high-availability vrrp group TRUSTED peer-address '10.1.2.6'
set high-availability vrrp group TRUSTED track interface 'bond0.3001'
