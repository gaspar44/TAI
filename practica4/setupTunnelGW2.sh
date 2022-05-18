#!/bin/bash
ip tunnel del name tunel0 &> /dev/null
ip tunnel add name tunel0 mode sit local 10.0.3.2 remote 10.0.0.1
ip link set tunel0 up

ip route add 2001::/64 dev tunel0
