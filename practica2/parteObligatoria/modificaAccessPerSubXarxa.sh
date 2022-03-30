#!/bin/bash
function usage() {
    echo    "usage:  "
    echo    "   --enable [Departament_number] enables Internet access to the specified net. Takes a value between 1 - 7"
    echo    "   --disable [Departament_number] disables Internet access to the specified net. Takes a value between 1 - 7"
    echo    "   --help. Shows this help and exit"
}

net_value=
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
        net_value=$2
        shift
        shift
        ;;
    --disable)
        enable=false
        net_value=$2
        shift
        shift
        ;;
    --help)
        usage
        exit 0
        ;;
    *)
        echo "- Unknown option: $@"
        usage
        exit 1
        ;;
    esac
done

if [[ -z ${net_value} ]]; then
    echo "- A number from 1 - 7 must be passed"
    usage
    exit 1
elif [[ ${net_value} -lt 1 ]] || [[ ${net_value} -gt 7 ]]; then
    echo "- A number from 1 - 7 must be passed"
    usage
    exit 1
fi

case $net_value in
    1)
        net="192.168.2.32/27"
        ;;
    2)
        net="192.168.2.64/27"
        ;;
    3)
        net="192.168.2.96/27"
        ;;
    4)
        net="192.168.2.128/27"
        ;;
    5)
        net="192.168.2.160/27"
        ;;
    6)
        net="192.168.2.192/27"
        ;;
    7)
        net="192.168.2.224/27"
        ;;
    *)
        break
        ;;
esac

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