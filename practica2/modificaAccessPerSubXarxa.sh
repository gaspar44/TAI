#!/bin/bash

function usage() {
    echo    "usage:  "
    echo    "   --enable [SUBNET_RANGE_CIDR_FORMAT] enables Internet access to the specified net"
    echo    "   --disable [SUBNET_RANGE_CIDR_FORMAT] disables Internet access to the specified net"
    echo    "   --help. Shows this help and exit"
}

net=
enable=

if [[ $# -lt 2 ]]; then
    echo "- No enough arguments"
    usage
    exit 1
fi

while [[ $# -gt 0 ]]; do
    case $1 in 
    --enable)
        enable=true
        net=$2
        shift
        shift
        ;;
    --disable)
        enable=false
        net=$2
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

iptables -C FORWARD -i eth2 -o eth1 &> /dev/null

if [[ $? != 0 ]]; then
    echo "- Executing script to activate routing"
    ./activaEmmascarament.sh
fi

base_command="FORWARD -s ${net} -j DROP"

if ${enable}; then
    echo "- Enabling net: ${net} to have Internet access"
        iptables -C ${base_command} &> /dev/null

    if [[ $? == 0 ]]; then
        iptables -D ${base_command}
    fi

else
    echo "- Disabling net: ${net} to have Internet access"    
    iptables -C ${base_command} &> /dev/null

    if [[ $? != 0 ]]; then
        iptables -A ${base_command}
    fi
fi