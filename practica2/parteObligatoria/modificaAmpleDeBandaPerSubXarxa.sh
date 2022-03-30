#!/bin/bash
function usage() {
    echo    "usage:  "
    echo    "   --department [Departament_number] change the outgoing net speed to the specified net. Takes a value between 1 - 7"
    echo    "   --new-ratio: new speed ratio in kbits. (Default: 20)"
    echo    "   --latency. Changes the waiting time in ms to get a token. (Default: 50ms)"
    echo    "   --burst. Changes the max output speed in Kbytes.(Default 10k)"
    echo    "   --interface. Which interface the change will be effective. (Default: eth0)"

    echo    "   --help. Shows this help and exit"
}

ratio=20
latency=50
burst=10
interface=eth0

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
    --interface)
        interface=$2
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

ip addr show ${interface} &> /dev/null

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

tc qdisc change dev ${interface} parent 1:${net_value} tbf rate ${ratio}kbit latency ${latency}ms burst ${burst}k

#Prueba  wget mirror.tedra.es/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-DVD-2009.iso
