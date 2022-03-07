#!/bin/bash
iptables -A OUTPUT -d 158.109.79.0/24 -j ACCEPT 
iptables -A OUTPUT -d ftp.rediris.es -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -j DROP