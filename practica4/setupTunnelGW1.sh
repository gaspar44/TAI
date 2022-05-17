#!/bin/bash
ip tunnel add name tunel0 mode sit local 10.0.0.1 remote 10.0.3.2
ip link set tunel0 up
ip route add 2002::/64 dev tunel0
