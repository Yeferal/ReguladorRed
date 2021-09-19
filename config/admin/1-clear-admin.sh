#!/bin/bash
echo "su -";
su -

echo "iptables -F ";
iptables -F 

echo "iptables -P INPUT ACCEPT";
iptables -P INPUT ACCEPT

echo "iptables -P OUTPUT ACCEPT";
iptables -P OUTPUT ACCEPT

echo "iptables -P FORWARD ACCEPT";
iptables -P FORWARD ACCEPT

echo "tc qdisc del dev enp0s3 root";
tc qdisc del dev enp0s3 root

echo "cat /dev/null > /var/spool/cron/crontabs/root ";
cat /dev/null > /var/spool/cron/crontabs/root 
