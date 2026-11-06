# Matter and Thread routing

VLAN 1100 is OTBR infrastructure (`fd74:f571:d3bd:1060::/64`); VLAN 1101
holds Matter controllers (`fd74:f571:d3bd:1061::/64`). VyOS uses `::1` on
each network. OTBR and Matter.js use `::2` on their respective networks,
allocated in NetBox and configured by Multus in the holywoo repository.
These attachments are IPv6-only and outside the ULA /56 reserved for WAN
NPT. Their MTU is 1500; Kubernetes node bonds retain MTU 9000.

`config-parts/matter-networks.sh` owns the interfaces, zones, Matter UDP
policies, mDNS extension and restricted RIO input. Matter discovery can
advertise dynamic UDP ports, including the controller's listening port;
the firewall scopes access by endpoint and prefix. Trusted commissioning
and replies are permitted. Home Assistant uses the existing Kubernetes
HTTP/WebSocket services, retaining its other network attachments.

OTBR retains MAC `0a:92:17:bd:44:6e` and link-local address
`fe80::892:17ff:febd:446e`. VyOS learns only /64 RIOs from that identity on
VLAN 1100. PIO, default-router and advertised MTU learning are disabled.
The Thread OMR remains `fd42:dfb5:24e4:1::/64`; there is no static IoT next
hop. IoT RA input is explicitly dropped, independently of VyOS restoring
its forwarding-mode `accept_ra` default during interface reconfiguration.

## VyOS 1.4 mDNS compatibility

Stock VyOS validates every interface as dual-stack when the mDNS repeater
uses `both`. Avahi supports a mixture of IPv4-only and IPv6-only links.
`scripts/patches/mdns-mixed-address-families.patch` fixes only that validation,
retaining the checks for interfaces with no enabled address family.

The preconfiguration boot hook applies the patch and reloads the configuration
daemon's cached modules before loading configuration. When installing these
files on an already running router, run
`sudo /config/scripts/vyos-preconfig-bootup.script` before the first commit.
The hook preserves the existing bind container directory setup. Review or
remove the compatibility patch when upgrading to a VyOS version with an
upstream fix. The hook has been tested for idempotence; no router reboot was
performed during this migration.

## Migration validation

On 2026-11-06, both attachments passed 1500-byte IPv6 tests on all three
Kubernetes nodes. After workload migration, the active Thread dataset was
unchanged, the Matter fabric retained all five available nodes, and VyOS
learned the OMR route via OTBR on VLAN 1100. All three workloads and their
Flux reconciliations were healthy. The data PVCs and Kubernetes Service URLs
were retained. The ICX carries these VLANs on LAG 1 and ports 1/2/1–1/2/3.
