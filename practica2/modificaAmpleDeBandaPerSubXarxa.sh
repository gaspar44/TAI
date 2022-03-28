#!/bin/bash

tc qdisc change dev eth0 parent 1:${i} tbf rate 10mbit latency 50ms burst 10k

#Prueba  wget mirror.tedra.es/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso
