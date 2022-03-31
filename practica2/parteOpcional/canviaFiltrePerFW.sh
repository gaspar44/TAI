#!/bin/bash

echo 200 col1.out >> /etc/iproute2/rt_tables
echo 201 col2.out >> /etc/iproute2/rt_tables

//Por GW-xarxa-1
ip rule add fwmark 1 table col1.out
ip rule add fwmark 2 table col1.out
ip rule add fwmark 3 table col1.out
//Por GW-xarxa-2
ip rule add fwmark 4 table col2.out
ip rule add fwmark 5 table col2.out
ip rule add fwmark 6 table col2.out
ip rule add fwmark 7 table col2.out

//Ip y interfaz por donde saldrán segun su tabla. 
ip route add table col1.out via 192.168.0.2/24 dev eth0
ip route add table col2.out via 192.168.1.2/24 dev eth1

//HAY QUE CAMBIAR LAS SUBNETS CUANDO SEPAMOS CUALES SON LAS CORRECTAS.
iptables -A OUTPUT -t mangle -s 192.168.2.33/27 -j MARK --set-mark 1
iptables -A OUTPUT -t mangle -s 192.168.2.65/27 -j MARK --set-mark 2
iptables -A OUTPUT -t mangle -s 192.168.2.97/27 -j MARK --set-mark 3
iptables -A OUTPUT -t mangle -s 192.168.2.129/27 -j MARK --set-mark 4
iptables -A OUTPUT -t mangle -s 192.168.2.161/27 -j MARK --set-mark 5
iptables -A OUTPUT -t mangle -s 192.168.2.193/27 -j MARK --set-mark 6
iptables -A OUTPUT -t mangle -s 192.168.2.225/27 -j MARK --set-mark 7
