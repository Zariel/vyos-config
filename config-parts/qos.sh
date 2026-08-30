# Upload: fair first between LAN source hosts, then between each host's flows.
set qos policy cake WAN-CAKE-EGRESS bandwidth '950mbit'
set qos policy cake WAN-CAKE-EGRESS flow-isolation dual-src-host
set qos policy cake WAN-CAKE-EGRESS flow-isolation nat
set qos policy cake WAN-CAKE-EGRESS rtt '20'
set qos policy cake WAN-CAKE-EGRESS description 'WAN upload CAKE'
set qos interface eth3 egress 'WAN-CAKE-EGRESS'

# Download: fair first between LAN destination hosts, then between each host's flows.
set qos policy cake WAN-CAKE-INGRESS bandwidth '890mbit'
set qos policy cake WAN-CAKE-INGRESS flow-isolation dual-dst-host
set qos policy cake WAN-CAKE-INGRESS flow-isolation nat
set qos policy cake WAN-CAKE-INGRESS rtt '20'
set qos policy cake WAN-CAKE-INGRESS description 'WAN download CAKE'

# Shape WAN ingress through an IFB.
set qos interface ifb0 egress 'WAN-CAKE-INGRESS'

# Configure the IFB plumbing after its shaping policy.
set interfaces ethernet eth3 redirect 'ifb0'
set interfaces input ifb0 description 'WAN ingress shaping'
