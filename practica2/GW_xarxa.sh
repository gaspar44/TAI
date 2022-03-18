#!/bin/bash
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -A FORWARD -i eth0 -o ctrl0
iptables -A FORWARD -i ctrl0 -o eth0 -m state --state RELATED,ESTABLISHED