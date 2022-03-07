#!/bin/bash
route add default gw 192.168.2.1 eth0
iptables -t mangle -A OUTPUT -m owner --uid-owner 999 -j TOS --set-tos 1
iptables -t mangle -A OUTPUT -m owner --uid-owner 998 -j TOS --set-tos 2
iptables -A OUTPUT -j LOG --log-prefix "iptables :" --log-uid

