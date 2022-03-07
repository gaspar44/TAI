#!/bin/bash
route add default gw 192.168.2.1 eth0
iptables -t mangle -A OUTPUT -m owner --uid-owner 999 -j TOS --set-tos 1
iptables -t mangle -A OUTPUT -m owner --uid-owner 998 -j TOS --set-tos 2
iptables -A OUTPUT -j LOG --log-prefix "iptables :" --log-uid
iptables -A OUTPUT -d 158.109.79.0/24 -j ACCEPT 
iptables -A OUTPUT -d ftp.rediris.es -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -j DROP
