#!/bin/bash

tc filter del dev eth0 parent 1: protocol ip prio 8 route from 8 flowid 1:8
tc filter add dev eth0 protocol ip parent 1: prio 10 u32 match ip src 192.168.0.2/32 flowid 1:8