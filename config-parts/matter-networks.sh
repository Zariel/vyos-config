#!/bin/vbash

# IPv6-only OTBR infrastructure and Matter controller networks.
set interfaces bonding bond0 vif 1100 description 'THREAD-INFRA'
set interfaces bonding bond0 vif 1100 address 'fd74:f571:d3bd:1060::1/64'
set interfaces bonding bond0 vif 1100 mtu '1500'
set interfaces bonding bond0 vif 1100 ipv6 adjust-mss 'clamp-mss-to-pmtu'
set interfaces bonding bond0 vif 1101 description 'MATTER-CONTROLLERS'
set interfaces bonding bond0 vif 1101 address 'fd74:f571:d3bd:1061::1/64'
set interfaces bonding bond0 vif 1101 mtu '1500'
set interfaces bonding bond0 vif 1101 ipv6 adjust-mss 'clamp-mss-to-pmtu'

set firewall zone thread interface 'bond0.1100'
set firewall zone matter interface 'bond0.1101'

# Add only the policies involving the new zones; preserve existing zone policy.
for matter_zone in thread matter; do
    set firewall zone "${matter_zone}" default-action 'drop'
    for matter_peer in guest iot lan local servers containers trusted transit wan thread matter; do
        if [[ "${matter_peer}" == "${matter_zone}" ]]; then
            continue
        fi
        # The thread iteration already creates both directions of this pair.
        if [[ "${matter_zone}" == matter && "${matter_peer}" == thread ]]; then
            continue
        fi
        for matter_direction in out in; do
            if [[ "${matter_direction}" == out ]]; then
                matter_from="${matter_zone}"
                matter_to="${matter_peer}"
            else
                matter_from="${matter_peer}"
                matter_to="${matter_zone}"
            fi

            set firewall zone "${matter_to}" from "${matter_from}" firewall name "${matter_from}-${matter_to}"
            set firewall zone "${matter_to}" from "${matter_from}" firewall ipv6-name "${matter_from}-${matter_to}"
            for matter_family in ipv4 ipv6; do
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" description "From ${matter_from^^} to ${matter_to^^}"
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" default-action 'drop'
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 1 action 'accept'
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 1 description 'Allow related and established'
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 1 state related
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 1 state established
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 999 action 'drop'
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 999 description 'Drop invalid'
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 999 state invalid
                set firewall "${matter_family}" name "${matter_from}-${matter_to}" rule 999 log
            done

            # Match the existing internal ICMPv6 policy, including ND and MLD.
            # No new WAN sessions are allowed from either internal-only network.
            if [[ "${matter_peer}" != wan ]]; then
                set firewall ipv6 name "${matter_from}-${matter_to}" rule 20 action 'accept'
                set firewall ipv6 name "${matter_from}-${matter_to}" rule 20 description 'Allow internal ICMPv6'
                set firewall ipv6 name "${matter_from}-${matter_to}" rule 20 protocol 'icmpv6'
            fi
        done
    done
done

# Provide an infrastructure PIO for OTBR's border-routing manager. Controllers
# will use static addressing/default routes; they do not need an RA service.
set service router-advert interface bond0.1100 prefix 'fd74:f571:d3bd:1060::/64'

# MLD queries keep the ICX's passive IPv6 snooping memberships refreshed.
set protocols pim6 interface bond0.1100 mld version '2'
set protocols pim6 interface bond0.1100 mld interval '125'
set protocols pim6 interface bond0.1101 mld version '2'
set protocols pim6 interface bond0.1101 mld interval '125'

# Never learn RAs on IoT. The controller network also uses forwarding mode
# without IPv6 autoconf, so its RAs are ignored.
set system sysctl parameter 'net.ipv6.conf.bond0/40.accept_ra' value '0'

# Interface reconfiguration can restore VyOS's forwarding-mode RA default.
# Enforce the IoT RA boundary in the input policy as well, while retaining ND.
set firewall ipv6 name iot-local rule 10 action 'drop'
set firewall ipv6 name iot-local rule 10 description 'Ignore router advertisements from IoT'
set firewall ipv6 name iot-local rule 10 protocol 'icmpv6'
set firewall ipv6 name iot-local rule 10 icmpv6 type-name 'nd-router-advert'

# Use the interface primitive to retain accept_ra=2 across bond reconfiguration.
# Suppress PIO/SLAAC, default-router and MTU learning; accept only /64 RIOs.
# The source filter below identifies OTBR by its retained MAC/link-local address.
set interfaces bonding bond0 vif 1100 ipv6 address autoconf
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_ra_defrtr' value '0'
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_ra_pinfo' value '0'
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_ra_mtu' value '0'
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_ra_rtr_pref' value '1'
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_ra_rt_info_min_plen' value '64'
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_ra_rt_info_max_plen' value '64'
set system sysctl parameter 'net.ipv6.conf.bond0/1100.accept_redirects' value '0'
set firewall ipv6 name thread-local rule 5 action 'accept'
set firewall ipv6 name thread-local rule 5 description 'Learn OMR RIOs only from OTBR'
set firewall ipv6 name thread-local rule 5 protocol 'icmpv6'
set firewall ipv6 name thread-local rule 5 icmpv6 type-name 'nd-router-advert'
set firewall ipv6 name thread-local rule 5 source address 'fe80::892:17ff:febd:446e'
set firewall ipv6 name thread-local rule 5 source mac-address '0a:92:17:bd:44:6e'
set firewall ipv6 name thread-local rule 10 action 'drop'
set firewall ipv6 name thread-local rule 10 description 'Ignore other infrastructure router advertisements'
set firewall ipv6 name thread-local rule 10 protocol 'icmpv6'
set firewall ipv6 name thread-local rule 10 icmpv6 type-name 'nd-router-advert'

# Matter uses UDP ports advertised by DNS-SD, including an ephemeral controller
# port (rather than only 5540). Scope both directions to the controller and OMR.
set firewall ipv6 name matter-thread rule 100 action 'accept'
set firewall ipv6 name matter-thread rule 100 description 'Matter controller to Thread devices'
set firewall ipv6 name matter-thread rule 100 protocol 'udp'
set firewall ipv6 name matter-thread rule 100 source address 'fd74:f571:d3bd:1061::2'
set firewall ipv6 name matter-thread rule 100 destination address 'fd42:dfb5:24e4:1::/64'
set firewall ipv6 name thread-matter rule 100 action 'accept'
set firewall ipv6 name thread-matter rule 100 description 'Thread device reports to Matter controller'
set firewall ipv6 name thread-matter rule 100 protocol 'udp'
set firewall ipv6 name thread-matter rule 100 source address 'fd42:dfb5:24e4:1::/64'
set firewall ipv6 name thread-matter rule 100 destination address 'fd74:f571:d3bd:1061::2'

# Preserve support for Matter devices on the existing IoT Wi-Fi network.
set firewall ipv6 name matter-iot rule 100 action 'accept'
set firewall ipv6 name matter-iot rule 100 description 'Matter controller to IoT devices'
set firewall ipv6 name matter-iot rule 100 protocol 'udp'
set firewall ipv6 name matter-iot rule 100 source address 'fd74:f571:d3bd:1061::2'
set firewall ipv6 name matter-iot rule 100 destination address 'fd74:f571:d3bd:40::/64'
set firewall ipv6 name iot-matter rule 100 action 'accept'
set firewall ipv6 name iot-matter rule 100 description 'IoT device reports to Matter controller'
set firewall ipv6 name iot-matter rule 100 protocol 'udp'
set firewall ipv6 name iot-matter rule 100 source address 'fd74:f571:d3bd:40::/64'
set firewall ipv6 name iot-matter rule 100 destination address 'fd74:f571:d3bd:1061::2'

# Trusted clients commission over the routed OMR and OTBR border-agent links.
set firewall ipv6 name trusted-thread rule 100 action 'accept'
set firewall ipv6 name trusted-thread rule 100 description 'Trusted commissioning of Thread devices'
set firewall ipv6 name trusted-thread rule 100 protocol 'udp'
set firewall ipv6 name trusted-thread rule 100 destination address 'fd42:dfb5:24e4:1::/64'
set firewall ipv6 name trusted-thread rule 101 action 'accept'
set firewall ipv6 name trusted-thread rule 101 description 'Trusted clients to OTBR border agent'
set firewall ipv6 name trusted-thread rule 101 protocol 'udp'
set firewall ipv6 name trusted-thread rule 101 destination address 'fd74:f571:d3bd:1060::2'
set firewall ipv6 name thread-trusted rule 100 action 'accept'
set firewall ipv6 name thread-trusted rule 100 description 'Thread reports to trusted Matter commissioners'
set firewall ipv6 name thread-trusted rule 100 protocol 'udp'
set firewall ipv6 name thread-trusted rule 100 source address 'fd42:dfb5:24e4:1::/64'
set firewall ipv6 name thread-trusted rule 100 destination address 'fd74:f571:d3bd:20::/64'
set firewall ipv6 name trusted-matter rule 100 action 'accept'
set firewall ipv6 name trusted-matter rule 100 description 'Trusted clients to Matter controller'
set firewall ipv6 name trusted-matter rule 100 protocol 'udp'
set firewall ipv6 name trusted-matter rule 100 destination address 'fd74:f571:d3bd:1061::2'

# Extend the existing service-filtered reflector without reflecting RAs or ND.
# The boot-time validator patch permits mixed IPv4/IPv6-only interfaces.
set service mdns repeater ip-version 'both'
set service mdns repeater interface 'bond0.1100'
set service mdns repeater interface 'bond0.1101'
set service mdns repeater allow-service '_matterc._udp.local'
set service mdns repeater allow-service '_matter._tcp.local'
set service mdns repeater allow-service '_matterd._udp.local'
for matter_zone in thread matter; do
    for matter_policy in "${matter_zone}-local" "local-${matter_zone}"; do
        set firewall ipv6 name "${matter_policy}" rule 110 action 'accept'
        set firewall ipv6 name "${matter_policy}" rule 110 description 'Allow reflected mDNS'
        set firewall ipv6 name "${matter_policy}" rule 110 protocol 'udp'
        set firewall ipv6 name "${matter_policy}" rule 110 source port '5353'
        set firewall ipv6 name "${matter_policy}" rule 110 destination port '5353'
    done
done
