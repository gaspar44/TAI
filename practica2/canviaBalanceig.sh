#!/bin/bash

ip route add default scope global nexthop via 192.168.0.1 dev eth0 weight 1 \
nexthop via 192.168.1.1 dev eth1 weight 1