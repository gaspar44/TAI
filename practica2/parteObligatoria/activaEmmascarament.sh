#!/bin/bash

iptables -t mangle -A PREROUTING -s 192.168.2/24 -j LOG --log-prefix "forwarding from /24"
### NAT: using eth1's IO
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -A PREROUTING -t mangle -s 192.168.2.32/27 -j MARK --set-mark 1
iptables -A PREROUTING -t mangle -s 192.168.2.64/27 -j MARK --set-mark 2
iptables -A PREROUTING -t mangle -s 192.168.2.96/27 -j MARK --set-mark 3
iptables -A PREROUTING -t mangle -s 192.168.2.128/27 -j MARK --set-mark 4
iptables -A PREROUTING -t mangle -s 192.168.2.160/27 -j MARK --set-mark 5
iptables -A PREROUTING -t mangle -s 192.168.2.192/27 -j MARK --set-mark 6
iptables -A PREROUTING -t mangle -s 192.168.2.224/27 -j MARK --set-mark 7

## FORWARD
iptables -A FORWARD -i eth2 -o eth1
iptables -A FORWARD -i eth1 -o eth2 -m state --state RELATED,ESTABLISHED

iptables -A FORWARD -i eth2 -o eth0
iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED
