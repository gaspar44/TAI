#!/bin/bash

function usage() {
    echo    "usage:  "
    echo    "   --eth0-load VALUE. Must be a integer between 0 - 100. (Default: 50)"
    echo    "   --eth1-load VALUE. Must be a integer between 0 - 100. (Default: 50)"
    echo    "   --help. Shows this help and exit"
}

if [[ $# -gt 4 ]]; then
    echo "- Too many arguments"
    usage
    exit 1
fi


while [[ $# -gt 0 ]]; do
    case $1 in
    --eth0-load)
        eth0_weight=$2
        shift
        shift
        ;;
    --eth1-load)
        eth1_weight=$2
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

if [[ -z ${eth0_weight} ]] && [[ -z ${eth1_weight} ]]; then
    eth0_weight=50
    eth1_weight=50

elif [[ -z ${eth0_weight} ]] && [[ -n ${eth1_weight} ]]; then
    eth0_weight=$((100 - ${eth1_weight}))

elif [[ -z ${eth1_weight} ]] && [[ -n ${eth0_weight} ]]; then
    eth1_weight=$((100 - ${eth0_weight}))
fi

total_weight=$((${eth0_weight} + ${eth1_weight}))

if [[ "${total_weight}" -ne "100" ]]; then
    echo "ERROR: values must sum 100"
    exit 1
fi

ip route del default &> /dev/null
echo "- Changing the route eth0 to ${eth0_weight}"
echo "- Changing the route eth1 to ${eth1_weight}"

ip route add default scope global nexthop via 192.168.0.1 dev eth0 weight ${eth0_weight} \
nexthop via 192.168.1.1 dev eth1 weight ${eth1_weight}