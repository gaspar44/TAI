#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward
### MANGLE: Packet manipulation
iptables -t mangle -A PREROUTING -m tos --tos 1 -j LOG --log-prefix "user1: FORWARDING "
iptables -t mangle -A PREROUTING -m tos --tos 2 -j LOG --log-prefix "user2: DROP "
iptables -t mangle -A PREROUTING -m tos --tos 2 -j DROP

### NAT: using eth1's IO
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

## FORWARD
iptables -A FORWARD -i eth0 -o eth1
iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED

./black_list.sh
./white_list.sh
./deic_rediris.sh
./disable_traceroute.sh

#iptables -A INPUT -s 192.168.1.1/24 -j  DROP #opcional, bloquear traceroute de internet  al gateway

/etc/init.d/rsyslog restart
