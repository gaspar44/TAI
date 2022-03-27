#!/bin/bash

iptables -t mangle -A PREROUTING -s 192.168.2/24 -j LOG --log-prefix "forwarding from /24"
### NAT: using eth1's IO
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

## FORWARD
iptables -A FORWARD -i eth2 -o eth1
iptables -A FORWARD -i eth1 -o eth2 -m state --state RELATED,ESTABLISHED
#iptables -t mangle -A FORWARD -i eth2 -o eth1 -s 192.168.2.32/27 -j MARK --set-mark 1

iptables -A FORWARD -i eth2 -o eth0
iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED
