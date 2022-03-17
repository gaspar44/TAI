#!/bin/bash

iptables -t mangle -A PREROUTING -s 192.168.2/24 -j LOG --log-prefix "forwarding from /24"
### NAT: using eth1's IO
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE

## FORWARD
iptables -A FORWARD -i eth2 -o eth1
iptables -A FORWARD -i eth1 -o eth2 -m state --state RELATED,ESTABLISHED

iptables -A FORWARD -i eth2 -o eth0
iptables -A FORWARD -i eth0 -o eth2 -m state --state RELATED,ESTABLISHED
