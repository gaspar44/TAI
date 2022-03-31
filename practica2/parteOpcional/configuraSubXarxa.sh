#!/bin/bash

function usage() {
    echo "      Adds a IP to the host depending of wich sub network belongs"
    echo "      --sub-net [VALUE]. Takes a value between 1 - 7 to define the department witch belongs"
    echo "      --help. Shows this help and exit"

}

if [[ $# -ne 2 ]]; then
    echo "- Too many arguments"
    usage
    exit 1
fi


while [[ $# -gt 0 ]]; do
    case $1 in
    --sub-net)
        net_value=$2
        shift
        shift
        ;;
    --help)
        usage
        exit 0
        ;;
    *)
        usage
        exit 1
        ;;
    esac
done

if [[ ${net_value} -gt 7 ]] || [[ ${net_value} -lt 1 ]]; then
    echo "- Value: ${net_value} invalid"
    usage
    exit 1
fi

case "$net_value" in
    1)
        gateway_ip="192.168.2.33"
        net="192.168.2.34/27"
        ;;
    2)
        gateway_ip="192.168.2.65"
        net="192.168.2.66/27"
        ;;
    3)
        gateway_ip="192.168.2.97"
        net="192.168.2.98/27"
        ;;
    4)
        gateway_ip="192.168.2.129"
        net="192.168.2.130/27"
        ;;
    5)
        gateway_ip="192.168.2.161"
        net="192.168.2.162/27"
        ;;
    6)
        gateway_ip="192.168.2.193"
        net="192.168.2.194/27"
        ;;
    7)
        gateway_ip="192.168.2.225"
        net="192.168.2.226/27"
        ;;
    *)
        exit 1
        ;;
esac

ip addr del ${net} dev eth0 &> /dev/null

echo "- Adding ip ${net} to eth0"
ip addr add ${net} dev eth0

ip route del default &> /dev/null
echo "- Adding ${gateway_ip} as default routing route"
ip route add default via ${gateway_ip}