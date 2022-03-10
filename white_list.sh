#!/bin/bash

iptables -N WHITE_LIST
iptables -A WHITE_LIST -j LOG --log-prefix "SSH connection arrived "
iptables -A WHITE_LIST -s 192.168.2.0/24 -j ACCEPT
iptables -A WHITE_LIST -j LOG --log-prefix "SSH connection refused "
iptables -A WHITE_LIST -j DROP

iptables -A WHITE_LIST -p tcp --dport 22 -j WHITE_LIST
#No deberia ser ?  --> iptables -A INPUT -p tcp --dport 22 -j WHITE_LIST
