#!/bin/bash

function setup_tc() {
    local dev="$1"
    local queue_to_create="$2"

    tc qdisc del dev ${dev} root handle 1: prio bands ${queue_to_create} &> /dev/null
    tc qdisc add dev ${dev} root handle 1: prio bands ${queue_to_create}
    echo "- Creating default bitbucket for dev: ${dev}"
    for (( i=1; i<=${queue_to_create}; i++ ))
    do
        tc qdisc del dev ${dev} parent 1:${i} handle ${i}0:0 tbf rate 20kbit latency 50ms burst 10k &> /dev/null
        tc qdisc add dev ${dev} parent 1:${i} handle ${i}0:0 tbf rate 20kbit latency 50ms burst 10k
        tc filter del dev ${dev} parent 1: protocol ip prio ${i} route from ${i} flowid 1:${i} &> /dev/null
        tc filter add dev ${dev} parent 1: protocol ip prio ${i} route from ${i} flowid 1:${i}
    done
}

function setup_routing() {
    local departments="$1"

    for (( i=1; i<${departments}; i++ ))
    do
    case $i in
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

    ip route del ${net} dev eth2 realm $i &> /dev/null
    ip route add ${net} dev eth2 realm $i

    done
}

queue_to_create=8
setup_routing ${queue_to_create}
setup_tc "eth0" ${queue_to_create}
setup_tc "eth1" ${queue_to_create}

