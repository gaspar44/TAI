#!/bin/bash
iptables -A FORWARD -d 158.109.79.0/24 -j ACCEPT
iptables -A FORWARD -d ftp.rediris.es -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -j DROP