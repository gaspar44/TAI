#!/bin/bash
function usage() {
    echo    "usage:  "
    echo    "   --department [Departament_number] change the outgoing net speed to the specified net. Takes a value between 1 - 7"
    echo    "   --new-ratio: new speed ratio in kbits. (Default: 20)"
    echo    "   --latency. Changes the waiting time in ms to get a token. (Default: 50ms)"
    echo    "   --burst. Changes the max output speed in Kbytes.(Default 10k)"
    echo    "   --help. Shows this help and exit"
}

ratio=20
latency=50
burst=10

while [[ $# -gt 0 ]]; do
    case $1 in 
    --department)
        net_value=$2
        shift
        shift
        ;;
    --new-ratio)
        ratio=$2
        shift
        shift
        ;;
    --latency)
        latency=$2
        shift
        shift
        ;;
    --burst)
        burst=$2
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

ip addr show eth0 &> /dev/null
ip addr show eth1 &> /dev/null

if [[ $? == 1 ]]; then
    echo "- Unknown interface: ${interface}"
    exit 1
fi

if [[ -z ${net_value} ]]; then
    echo "- A number from 1 - 7 must be passed"
    usage
    exit 1
elif [[ ${net_value} -lt 1 ]] || [[ ${net_value} -gt 7 ]]; then
    echo "- A number from 1 - 7 must be passed"
    usage
    exit 1
fi

eth1_ip="192.168.1.1"
eth0_ip="192.168.0.1"

porcentaje0=0.$(ip r s | grep ${eth0_ip} | awk ' { print $7 } ')
porcentaje1=0.$(ip r s | grep ${eth1_ip} | awk ' { print $7 } ')

new_ratio0=$(echo "$ratio*$_porcentaje0" | bc)
new_ratio1=$(echo "$ratio*$_porcentaje1" | bc)

tc qdisc change dev eth0 parent 1:${net_value} tbf rate ${new_ratio0}kbit latency ${latency}ms burst ${burst}k
tc qdisc change dev eth1 parent 1:${net_value} tbf rate ${new_ratio1}kbit latency ${latency}ms burst ${burst}k

#Prueba  wget mirror.tedra.es/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso