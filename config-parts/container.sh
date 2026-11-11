#!/bin/vbash

# Container networks
set container network containers description 'Network for VyOS containers'
set container network containers prefix '10.5.0.0/24'
set container network containers prefix 'fd74:f571:d3bd:1005::/64'

# node-exporter
set container name node-exporter arguments '--web.listen-address=10.254.254.1:9100'
set container name node-exporter environment procfs value '/host/proc'
set container name node-exporter environment rootfs value '/host/rootfs'
set container name node-exporter environment sysfs value '/host/sys'
set container name node-exporter image 'quay.io/prometheus/node-exporter:v1.12.1'
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

# matchbox
set container name matchbox arguments '-address=0.0.0.0:80 -log-level=debug'
set container name matchbox cap-add 'net-bind-service'
set container name matchbox image 'quay.io/poseidon/matchbox:v0.11.0'
set container name matchbox memory '0'
set container name matchbox network containers address '10.5.0.8'
set container name matchbox shared-memory '0'
set container name matchbox volume matchbox-data destination '/var/lib/matchbox'
set container name matchbox volume matchbox-data mode 'rw'
set container name matchbox volume matchbox-data propagation 'private'
set container name matchbox volume matchbox-data source '/config/containers/matchbox'
