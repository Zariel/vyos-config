#!/bin/vbash

# NTP server
delete service ntp allow-client
set service ntp allow-client address '127.0.0.0/8'
set service ntp allow-client address '10.0.0.0/8'
set service ntp allow-client address '172.16.0.0/12'
set service ntp allow-client address '192.168.0.0/16'

delete service ntp server
set service ntp server 0.uk.pool.ntp.org
set service ntp server 1.uk.pool.ntp.org
set service ntp server 2.uk.pool.ntp.org
set service ntp server 3.uk.pool.ntp.org

# SSH server
set service ssh disable-password-authentication
set service ssh port '22'

# TFTP server
set service tftp-server directory '/config/tftpboot'
set service tftp-server listen-address 10.1.1.1

# mDNS Repeater
set service mdns repeater interface 'bond0.20'
set service mdns repeater interface 'bond0.40'

# TODO: enable when roon is in IOT
# UDP Broadcast-Relay
# set service broadcast-relay id 1 description 'ROON'
# set service broadcast-relay id 1 interface 'bond0.20'
# set service broadcast-relay id 1 interface 'bond0.40'
# set service broadcast-relay id 1 port '9003'

# set service router-advert interface bond0.20 default-preference 'high'
# set service router-advert interface bond0.40 default-preference 'high'
# set service router-advert interface bond0.40 prefix ::/64

# set service router-advert interface bond0.20 prefix ::/64
# ULA
set service router-advert interface bond0.20 prefix fd74:f571:d3bd:20::/64
set service router-advert interface bond0.20 route fd74:f571:d3bd::/48
set service router-advert interface bond0.20 name-server fd74:f571:d3bd:1005::4
set service router-advert interface bond0.20 default-preference 'high'

set service router-advert interface bond0.40 prefix fd74:f571:d3bd:40::/64
set service router-advert interface bond0.40 route fd74:f571:d3bd::/48
set service router-advert interface bond0.40 name-server fd74:f571:d3bd:1005::4
set service router-advert interface bond0.40 default-preference 'high'
