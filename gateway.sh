#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -t nat -A PREROUTING -j LOG --log-prefix "iptables :"
iptables -A FORWARD -m tos --tos 2 -j DROP
iptables -A FORWARD -i eth0 -o eth1
iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED

# IPTABLES_CONFIG_FOR_RSYSLOG_FILE="/etc/rsyslog.conf"
# echo '$template ipTraffic,"%$day%/%$month%/%$year% %timegenerated:12:19:date-rfc3339%, %msg%\n"' >> ${IPTABLES_CONFIG_FOR_RSYSLOG_FILE}
# echo "kern.*; /var/log/kern.log; ipTraffic" >> ${IPTABLES_CONFIG_FOR_RSYSLOG_FILE}

/etc/init.d/rsyslog start
