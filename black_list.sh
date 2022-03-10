#!/bin/bash

iptables -N BLACK_LIST
iptables -A BLACK_LIST -j LOG --log-prefix "Not allowed use to HTTP server "
iptables -A BLACK_LIST -j DROP

iptables -A INPUT -s 192.168.1.0/24 -p tcp --dport 80 -j BLACK_LIST