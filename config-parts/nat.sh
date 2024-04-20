#!/bin/vbash

# LAN -> WAN masquerade
set nat source rule 100 description 'LAN -> WAN'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 outbound-interface name 'eth2'
set nat source rule 100 translation address 'masquerade'

# Force DNS
set nat destination rule 200 description 'Force DNS for IoT'
set nat destination rule 200 destination address '!10.5.0.4'
set nat destination rule 200 destination port '53'
set nat destination rule 200 inbound-interface name 'bond0.40'
set nat destination rule 200 protocol 'tcp_udp'
set nat destination rule 200 translation address '10.5.0.4'
set nat destination rule 200 translation port '53'

# Force NTP
set nat destination rule 300 description 'Force NTP for LAN'
set nat destination rule 300 destination address '!10.1.0.1'
set nat destination rule 300 destination port '123'
set nat destination rule 300 inbound-interface name 'bond0'
set nat destination rule 300 protocol 'udp'
set nat destination rule 300 translation address '10.1.0.1'
set nat destination rule 300 translation port '123'

set nat destination rule 301 description 'Force NTP for Servers'
set nat destination rule 301 destination address '!10.1.1.1'
set nat destination rule 301 destination port '123'
set nat destination rule 301 inbound-interface name 'bond0.10'
set nat destination rule 301 protocol 'udp'
set nat destination rule 301 translation address '10.1.1.1'
set nat destination rule 301 translation port '123'

set nat destination rule 302 description 'Force NTP for Trusted'
set nat destination rule 302 destination address '!10.1.2.1'
set nat destination rule 302 destination port '123'
set nat destination rule 302 inbound-interface name 'bond0.20'
set nat destination rule 302 protocol 'udp'
set nat destination rule 302 translation address '10.1.2.1'
set nat destination rule 302 translation port '123'

set nat destination rule 303 description 'Force NTP for IoT'
set nat destination rule 303 destination address '!10.1.3.1'
set nat destination rule 303 destination port '123'
set nat destination rule 303 inbound-interface name 'bond0.40'
set nat destination rule 303 protocol 'udp'
set nat destination rule 303 translation address '10.1.3.1'
set nat destination rule 303 translation port '123'

set nat destination rule 400 description 'Forward port for Roon ARC'
set nat destination rule 400 destination port '59453'
set nat destination rule 400 inbound-interface name 'eth2'
set nat destination rule 400 protocol 'tcp'
set nat destination rule 400 translation address '10.1.2.60'
set nat destination rule 400 translation port '59453'
