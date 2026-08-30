#!/bin/sh
set -eu

interface=ifb0

ip link show dev "$interface" >/dev/null 2>&1 || exit 0
qdisc=$(tc qdisc show dev "$interface")

case "$qdisc" in
  qdisc\ cake\ *) ;;
  *) exit 0 ;;
esac

case " $qdisc " in
  *" ingress "*) exit 0 ;;
esac

sudo tc qdisc change dev "$interface" root cake ingress
