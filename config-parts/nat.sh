#!/bin/vbash

# LAN -> WAN masquerade
set nat source rule 100 description 'LAN -> WAN'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 outbound-interface name 'eth2'
set nat source rule 100 translation address 'masquerade'

# Force DNS
set nat destination rule 102 description 'Force DNS for IoT'
set nat destination rule 102 destination address '!10.5.0.4'
set nat destination rule 102 destination port '53'
set nat destination rule 102 inbound-interface name 'bond0.40'
set nat destination rule 102 protocol 'tcp_udp'
set nat destination rule 102 translation address '10.5.0.4'
set nat destination rule 102 translation port '53'

set nat destination rule 103 description 'Force DNS for Video'
set nat destination rule 103 destination address '!10.5.0.4'
set nat destination rule 103 destination port '53'
set nat destination rule 103 inbound-interface name 'bond0.50'
set nat destination rule 103 protocol 'tcp_udp'
set nat destination rule 103 translation address '10.5.0.4'
set nat destination rule 103 translation port '53'

# Force NTP
set nat destination rule 104 description 'Force NTP for LAN'
set nat destination rule 104 destination address '!10.1.0.1'
set nat destination rule 104 destination port '123'
set nat destination rule 104 inbound-interface name 'bond0'
set nat destination rule 104 protocol 'udp'
set nat destination rule 104 translation address '10.1.0.1'
set nat destination rule 104 translation port '123'

set nat destination rule 105 description 'Force NTP for Servers'
set nat destination rule 105 destination address '!10.1.1.1'
set nat destination rule 105 destination port '123'
set nat destination rule 105 inbound-interface name 'bond0.10'
set nat destination rule 105 protocol 'udp'
set nat destination rule 105 translation address '10.1.1.1'
set nat destination rule 105 translation port '123'

set nat destination rule 106 description 'Force NTP for Trusted'
set nat destination rule 106 destination address '!10.1.2.1'
set nat destination rule 106 destination port '123'
set nat destination rule 106 inbound-interface name 'bond0.20'
set nat destination rule 106 protocol 'udp'
set nat destination rule 106 translation address '10.1.2.1'
set nat destination rule 106 translation port '123'

set nat destination rule 107 description 'Force NTP for IoT'
set nat destination rule 107 destination address '!10.1.3.1'
set nat destination rule 107 destination port '123'
set nat destination rule 107 inbound-interface name 'bond0.40'
set nat destination rule 107 protocol 'udp'
set nat destination rule 107 translation address '10.1.3.1'
set nat destination rule 107 translation port '123'
