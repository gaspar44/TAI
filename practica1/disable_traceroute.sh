#!/bin/bash

iptables -A INPUT -s 192.168.1.0/24 -p ICMP --icmp-type 11 -j DROP