#!/bin/bash
IN_DEV=$1
if [ -z "$IN_DEV" ] ; then
	echo "Required parameter: Input device (e.g. eth1)"
	exit 1
fi
echo "Flushing iptables"
iptables -F
iptables -t nat -F
echo "Redirecting port 80 to local port 10000"
iptables -i $IN_DEV -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000
#echo "Redirecting port 443 to local port 10001"
#iptables -i $IN_DEV -t nat -A PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-port 10001
echo "Enabling IP forwarding"
echo 1 > /proc/sys/net/ipv4/ip_forward

