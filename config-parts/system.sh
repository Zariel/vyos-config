#!/bin/vbash

set system domain-name 'cbannister.casa'
set system host-name 'gateway'

set system static-host-mapping host-name gateway inet '10.1.0.1'

set system ipv6 disable-forwarding

set system login user vyos authentication public-keys personal key 'AAAAC3NzaC1lZDI1NTE5AAAAINiFPVXT03FdYS3BKuqNmgplaGrzNc6i++77vCI2AJ8c'
set system login user vyos authentication public-keys personal type 'ssh-ed25519'

set system name-server '1.1.1.1'

set system sysctl parameter kernel.pty.max value '24000'

set system syslog global facility all level info
# set system syslog host 10.45.0.2 facility kern level 'warning'
# set system syslog host 10.45.0.2 protocol 'tcp'
# set system syslog host 10.45.0.2 port '6001'
# set system syslog host 10.45.0.2 format 'octet-counted'

# set system task-scheduler task backup-config crontab-spec '30 0 * * *'
# set system task-scheduler task backup-config executable path '/config/scripts/task-config-backup-usb.sh'

set system time-zone 'Europe/London'
