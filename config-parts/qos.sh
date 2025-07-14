# QoS policy configuration
set qos policy cake WAN-CAKE bandwidth '1000mbit'
set qos policy cake WAN-CAKE flow-isolation nat
set qos policy cake WAN-CAKE flow-isolation triple-isolate
set qos policy cake WAN-CAKE rtt '50'

# Apply policy to interface
set qos interface eth2 egress 'WAN-CAKE'
