#!/bin/bash
tc qdisc change dev eth2 root cake bandwidth 1Gbit memlimit 32Mb triple-isolate nat rtt 50ms
