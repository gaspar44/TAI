#!/bin/bash

departments=9

for (( i=2; i<${departments}; i++ ))
do
    case $i in
        2)
            net="192.168.2.33/27"
            ;;
        3)
            net="192.168.2.65/27"
            ;;
        4)
            net="192.168.2.97/27"
            ;;
        5)
            net="192.168.2.129/27"
            ;;
        6)
            net="192.168.2.161/27"
            ;;
        7)
            net="192.168.2.193/27"
            ;;
        8)
            net="192.168.2.225/27"
            ;;
        *)
            break
            ;;
    esac

    ip addr del ${net} dev eth${i} &> /dev/null
    echo "- Adding ip ${net} to eth${i}"
    ip addr add ${net} dev eth${i}

done

ip route add default scope global nexthop via 192.168.0.1 dev eth0 weight 1 \
nexthop via 192.168.1.1 dev eth1 weight 1

for ((i=2; i<${departments}; i++ )) 
do
    iptables -t nat -A POSTROUTING -o eth${i} -j MASQUERADE

    for (( j=0; j<${departments}; j++ ))
    do
    if [[ ${i} != ${j} ]]; then
            iptables -A FORWARD -i eth${i} -o eth${j}
            iptables -A FORWARD -i eth${j} -o eth${i} -m state --state RELATED,ESTABLISHED
    fi
    done
done    
