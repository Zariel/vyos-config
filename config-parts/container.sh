#!/bin/vbash

# Container networks
set container network containers description 'Network for VyOS containers'
set container network containers prefix '10.5.0.0/24'
set container network containers prefix fdc0:7ebe:7a3e:ff00::/64

# haproxy-k8s-api
set container name haproxy-k8s-api image 'docker.io/library/haproxy:2.9.6'
set container name haproxy-k8s-api memory '0'
set container name haproxy-k8s-api network containers address '10.5.0.2'
set container name haproxy-k8s-api restart 'on-failure'
set container name haproxy-k8s-api shared-memory '0'
set container name haproxy-k8s-api volume config source '/config/containers/haproxy/config/haproxy.cfg'
set container name haproxy-k8s-api volume config destination '/usr/local/etc/haproxy/haproxy.cfg'
set container name haproxy-k8s-api volume config mode 'ro'

# bind
set container name bind cap-add 'net-bind-service'
set container name bind image 'docker.io/internetsystemsconsortium/bind9:9.21'
set container name bind arguments '-4 -g -c /etc/bind/named.conf'
set container name bind memory '0'
set container name bind network containers address '10.5.0.3'
set container name bind restart 'on-failure'
set container name bind shared-memory '0'
set container name bind volume config destination '/etc/bind'
set container name bind volume config source '/config/containers/bind/config'
set container name bind volume config mode 'ro'
set container name bind volume cache source '/tmp/bind/cache'
set container name bind volume cache destination '/var/cache/bind'
set container name bind volume cache mode 'rw'

# dnsdist
set container name dnsdist cap-add 'net-bind-service'
set container name dnsdist environment TZ value 'Europe/London'
set container name dnsdist image 'docker.io/powerdns/dnsdist-19:1.9.6'
set container name dnsdist arguments '--log-timestamps'
set container name dnsdist memory '0'
set container name dnsdist network containers address '10.5.0.4'
set container name dnsdist restart 'on-failure'
set container name dnsdist shared-memory '0'
set container name dnsdist volume config source '/config/containers/dnsdist/config/dnsdist.conf.lua'
set container name dnsdist volume config destination '/etc/dnsdist/dnsdist.conf'
set container name dnsdist volume config mode 'ro'

# blocky
set container name blocky image 'ghcr.io/0xerr0r/blocky:v0.25'
set container name blocky memory '0'
set container name blocky network containers address '10.5.0.7'
set container name blocky shared-memory '0'
set container name blocky restart 'on-failure'
set container name blocky environment TZ value 'Europe/London'
set container name blocky volume config source '/config/containers/blocky/config/config.yml'
set container name blocky volume config destination '/app/config.yml'
set container name blocky volume config mode 'ro'

# node-exporter
set container name node-exporter environment procfs value '/host/proc'
set container name node-exporter environment rootfs value '/host/rootfs'
set container name node-exporter environment sysfs value '/host/sys'
set container name node-exporter image 'quay.io/prometheus/node-exporter:v1.8.2'
set container name node-exporter memory '0'
set container name node-exporter allow-host-networks
set container name node-exporter restart 'on-failure'
set container name node-exporter shared-memory '0'
set container name node-exporter volume procfs source '/proc'
set container name node-exporter volume procfs destination '/host/proc'
set container name node-exporter volume procfs mode 'ro'
set container name node-exporter volume rootfs source '/'
set container name node-exporter volume rootfs destination '/host/rootfs'
set container name node-exporter volume rootfs mode 'ro'
set container name node-exporter volume sysfs source '/sys'
set container name node-exporter volume sysfs destination '/host/sys'
set container name node-exporter volume sysfs mode 'ro'

# speedtest-exporter
set container name speedtest-exporter image 'ghcr.io/miguelndecarvalho/speedtest-exporter:v3.5.4'
set container name speedtest-exporter memory '0'
set container name speedtest-exporter allow-host-networks
set container name speedtest-exporter restart 'on-failure'
set container name speedtest-exporter shared-memory '0'

# unifi
set container name unifi environment TZ value 'Europe/London'
set container name unifi environment RUNAS_UID0 value 'false'
set container name unifi environment PGID value '102'
set container name unifi environment PUID value '999'
set container name unifi image 'ghcr.io/goofball222/unifi:9.0.114'
set container name unifi memory '0'
set container name unifi network containers address '10.5.0.10'
set container name unifi restart 'on-failure'
set container name unifi shared-memory '0'
set container name unifi volume cert source '/config/containers/unifi/cert'
set container name unifi volume cert destination '/usr/lib/unifi/cert'
set container name unifi volume cert mode 'rw'
set container name unifi volume data source '/config/containers/unifi/data'
set container name unifi volume data destination '/usr/lib/unifi/data'
set container name unifi volume data mode 'rw'
set container name unifi volume logs source '/config/containers/unifi/logs'
set container name unifi volume logs destination '/usr/lib/unifi/logs'
set container name unifi volume logs mode 'rw'

# matchbox
set container name matchbox arguments '-address=0.0.0.0:80 -log-level=debug'
set container name matchbox cap-add 'net-bind-service'
set container name matchbox image 'quay.io/poseidon/matchbox:v0.10.0'
set container name matchbox memory '0'
set container name matchbox network containers address '10.5.0.8'
set container name matchbox shared-memory '0'
set container name matchbox volume matchbox-data destination '/var/lib/matchbox'
set container name matchbox volume matchbox-data mode 'rw'
set container name matchbox volume matchbox-data propagation 'private'
set container name matchbox volume matchbox-data source '/config/containers/matchbox'
