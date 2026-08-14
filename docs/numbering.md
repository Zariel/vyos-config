# Network Numbering Plan

## Transit Networks

| Purpose                 |  VLAN range | Address range    |
| ----------------------- | ----------: | ---------------- |
| Router / switch transit | `3000-3099` | `10.254.0.0/24`  |
| DNS / infra transit     | `3100-3199` | `10.254.53.0/24` |
| Kubernetes transit      | `3200-3299` | `10.254.1.0/24`  |

Point-to-point links use `/31` subnets.

### Router / Switch Fabric

| Link            |   VLAN | Subnet          |
| --------------- | -----: | --------------- |
| VyOS ↔ Core     | `3001` | `10.254.0.0/31` |
| Core ↔ Switch 2 | `3002` | `10.254.0.2/31` |
| Core ↔ Switch 3 | `3003` | `10.254.0.4/31` |
| Core ↔ Switch 4 | `3004` | `10.254.0.6/31` |

### Kubernetes

| Link         |   VLAN | Subnet          |
| ------------ | -----: | --------------- |
| Core ↔ k8s-1 | `3201` | `10.254.1.0/31` |
| Core ↔ k8s-2 | `3202` | `10.254.1.2/31` |
| Core ↔ k8s-3 | `3203` | `10.254.1.4/31` |

### DNS / Infrastructure

| Link         |   VLAN | Subnet           |
| ------------ | -----: | ---------------- |
| Core ↔ dns-1 | `3101` | `10.254.53.0/31` |
| Core ↔ dns-2 | `3102` | `10.254.53.2/31` |
| Core ↔ dns-3 | `3103` | `10.254.53.4/31` |

## Loopbacks

`10.254.254.0/24` is reserved for stable device identities and routing IDs.

| Device   | Loopback            |
| -------- | ------------------- |
| VyOS     | `10.254.254.1/32`   |
| Core     | `10.254.254.10/32`  |
| Switch 2 | `10.254.254.20/32`  |
| Switch 3 | `10.254.254.21/32`  |
| k8s-1    | `10.254.254.128/32` |
| k8s-2    | `10.254.254.129/32` |
| k8s-3    | `10.254.254.130/32` |
| dns-1    | `10.254.254.160/32` |
| dns-2    | `10.254.254.161/32` |
| dns-3    | `10.254.254.162/32` |

## Infrastructure VIPs

`10.254.253.0/24` is reserved for movable infrastructure service addresses.

Example:

```text
10.254.253.53/32    DNS resolver VIP
```

Loopbacks identify individual devices; VIPs identify services and may move between devices.

## BGP ASNs

| Purpose                       |           ASN |
| ----------------------------- | ------------: |
| VyOS / edge                   |       `65000` |
| Core                          |       `65001` |
| Additional switches / routers | `65002-65049` |
| Kubernetes cluster            |       `65100` |
| DNS / infrastructure          |       `65110` |
| Lab / temporary peers         |      `65200+` |

All Kubernetes nodes normally share `AS65100`. If the switching platform cannot perform BGP multipath across multiple peers in the same neighbouring AS, allocate per-node ASNs such as `65101-65103`.

## Summary

```text
10.254.0.0/24       router / switch transit
10.254.1.0/24       Kubernetes transit
10.254.53.0/24      DNS / infra transit
10.254.253.0/24     infrastructure VIPs
10.254.254.0/24     loopbacks

3000-3099           router / switch transit VLANs
3100-3199           DNS / infra transit VLANs
3200-3299           Kubernetes transit VLANs

65000               edge
65001-65049         network devices
65100-65199         server / cluster routing domains
65200+              lab / temporary
```
