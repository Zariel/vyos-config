# Trusted gateway migration

This configuration is prepared locally. Deploy and test the backup VM and ICX
routing before taking the gateway offline. Management's move to the ICX is a
separate change; this preparation does not move its addresses or DHCP scope.

| Purpose | Address / setting |
| --- | --- |
| Trusted network | VLAN 20, `10.1.2.0/24` |
| Shared IPv4 gateway | `10.1.2.1/24` |
| Permanent VyOS address | `10.1.2.5/32` |
| Permanent backup VM address | `10.1.2.6/32` |
| VRRP group / VRID | `TRUSTED` / `20` |
| VyOS priority | `200` |
| Suggested backup priority | `100` |
| Advertisement interval | 1 second |
| Transport | Unicast between `.5` and `.6`, IP protocol 112 |

Confirm/reserve the permanent addresses in NetBox before deployment. Both peers
must use the same VRRP version; this VyOS configuration uses the 1.4 default,
version 2 for IPv4. Configure the VM explicitly for version 2. Both peers should
start in BACKUP state with preemption disabled. Start VyOS first for the initial
rollout so it owns the VIP before enabling the VM. Later, a recovered primary
will remain in backup until an intentional handover.

The VIP is placed directly on `bond0.20`. Existing trusted-zone and DNS-redirect
interface matches remain applicable. Gratuitous ARP updates clients when the
VIP changes owners. DHCP advertises `.1` and DNS `10.254.253.53`; the legacy DNS
VIP `172.53.53.53` remains allowed during migration. Forced DNS uses the new VIP
and exempts direct requests to either address. The configured lease is eight
hours, with each client's remaining lifetime applying during an outage. DHCP
is not replicated to the backup VM.

## Routing ownership

The VM needs its own ICX transit and BGP session, independent of VyOS's
`10.254.0.0/31` transit. It learns the DNS VIP, Kubernetes and management routes
from the ICX. It advertises `10.1.2.0/24` only while owning `.1`, and does not
originate a default route. Preserve the intended internal firewall policy and
route without NAT. The ICX must accept the VM's trusted prefix and forward it to
downstream peers so return traffic follows the active gateway.

The permanent addresses are `/32`s so they do not create a connected route for
the whole trusted subnet. VRRP adds `.1/24` only on the active router, creating
the connected `10.1.2.0/24` route. Removing the VIP removes that connected route.

VyOS redistributes connected routes through the `BGP-CONNECTED-TRUSTED` route map,
which permits only the exact trusted `/24` on `bond0.20`. All other connected
routes, including the permanent node `/32`, are excluded by its implicit deny.
FRR therefore originates and withdraws the trusted prefix with VRRP ownership,
without transition scripts, runtime policy edits, or boot/commit synchronization.
Other existing BGP network statements are retained.

The core's outbound map `BGP-TO-CORE` permits only empty AS paths, identifying
local originations. ICX-learned routes, including a trusted `/24` originated by
the VM, are not echoed back to the ICX. This policy is fully declarative.

Both routers also need an explicit static on-link route for `10.1.2.0/24` through
their trusted interface. This allows ARP and direct replies to trusted clients,
including the other VRRP peer, while standing by with only a `/32`. The connected
route takes precedence while MASTER; the static route remains while BACKUP.
**Do not originate trusted with a BGP `network` statement or redistribute this
static route:** either would advertise the standby's subnet too. The VM needs
the same filtered connected-redistribution model.

The MASTER sends VRRP advertisements every second. A BACKUP listens for those
advertisements and takes over when its master-down timer expires, normally
around three to four seconds with these settings. This detects loss of the
active VRRP peer; it does not probe the peer's forwarding, BGP, DNS or internet
connectivity. Native tracking also puts VyOS into FAULT if `bond0.3001` goes
down. There are no custom health-check or transition scripts.

## Installation and validation

Review the configuration diff, particularly the address change from `.1/24` to `.5/32`
and the addition of `.1` to VRRP. Use a connection independent of the floating
gateway when applying it. Verify:

```sh
show vrrp
ip -4 address show dev bond0.20
show ip route 10.1.2.0/24
show ip bgp neighbors 10.254.0.1 advertised-routes
```

On the primary, `.5` remains present in every role and `.1` appears only in
MASTER. The trusted `/24` is exported only when `.1` is present. Check the
selected return route on the ICX as well as forward access to DNS, Kubernetes
and management. Test failover and failback before reinstalling the primary, and
test a normal configuration commit while MASTER. Verify that the static `/24`
survives in BACKUP without a locally originated trusted prefix in BGP.
Existing connections can require reconnection because conntrack state is not
replicated.

IPv6 addressing and router advertisements are unchanged and do not gain VRRP
failover from this IPv4 configuration. Other VyOS-owned VLAN gateways also
require their own migration plan.

To roll back, remove the TRUSTED VRRP group, replace `.5/32` with `10.1.2.1/24`,
remove the trusted static interface route and connected-redistribution policy,
and restore the original BGP `network 10.1.2.0/24` statement.

References: [VyOS 1.4 high availability](https://docs.vyos.io/en/1.4/configuration/highavailability/),
[FRR prefix lists and route maps](https://docs.frrouting.org/en/stable-9.1/filter.html).
