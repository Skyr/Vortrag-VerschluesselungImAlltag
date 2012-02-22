#!/bin/bash
IN_DEV=$1
if [ -z "$IN_DEV" ] ; then
	echo "Required parameter: Input device (e.g. eth1)"
	exit 1
fi
echo "Flushing iptables"
iptables -F
iptables -t nat -F
echo "Intercepting port 80 and 443"
iptables -i $IN_DEV -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 80
iptables -i $IN_DEV -t nat -A PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-port 443
echo "Enabling IP forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

