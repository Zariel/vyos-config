#!/bin/vbash

set system domain-name 'cbannister.casa'
set system host-name 'gateway'

set system static-host-mapping host-name gateway inet '10.1.0.1'

# set system ipv6 disable-forwarding

set system login user vyos authentication public-keys personal key 'AAAAC3NzaC1lZDI1NTE5AAAAINiFPVXT03FdYS3BKuqNmgplaGrzNc6i++77vCI2AJ8c'
set system login user vyos authentication public-keys personal type 'ssh-ed25519'

set system name-server '1.1.1.1'
set system name-server '2606:4700:4700::1111'

set system sysctl parameter kernel.pty.max value '24000'

set system syslog global facility all level info
set system syslog host 10.45.0.2 facility kern level 'warning'
set system syslog host 10.45.0.2 protocol 'tcp'
set system syslog host 10.45.0.2 port '6001'
set system syslog host 10.45.0.2 format 'octet-counted'

set system time-zone 'Europe/London'

set system option kernel disable-mitigations

set system sysctl parameter net.core.default_qdisc value 'fq'
set system sysctl parameter net.core.netdev_budget value '1200'
set system sysctl parameter net.core.netdev_budget_usecs value '8000'
set system sysctl parameter net.core.netdev_max_backlog value '30000'
set system sysctl parameter net.core.rmem_max value '67108864'
set system sysctl parameter net.core.wmem_max value '67108864'
set system sysctl parameter net.ipv4.ip_forward_use_pmtu value '1'
set system sysctl parameter net.ipv4.tcp_congestion_control value 'bbr'
set system sysctl parameter net.ipv4.tcp_moderate_rcvbuf value '1'
set system sysctl parameter net.ipv4.tcp_mtu_probing value '1'
set system sysctl parameter net.ipv4.tcp_no_metrics_save value '1'
set system sysctl parameter net.ipv4.tcp_rmem value '4096 87380 33554432'
set system sysctl parameter net.ipv4.tcp_slow_start_after_idle value '0'
set system sysctl parameter net.ipv4.tcp_window_scaling value '1'
set system sysctl parameter net.ipv4.tcp_wmem value '4096 87380 33554432'
