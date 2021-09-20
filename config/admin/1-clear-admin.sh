#!/bin/bash

echo "iptables -F ";
iptables -F 

echo "iptables -P INPUT ACCEPT";
iptables -P INPUT ACCEPT

echo "iptables -P OUTPUT ACCEPT";
iptables -P OUTPUT ACCEPT

echo "iptables -P FORWARD ACCEPT";
iptables -P FORWARD ACCEPT

echo "tc qdisc del dev enp0s8 root";
tc qdisc del dev enp0s8 root

echo "cat /dev/null > /var/spool/cron/crontabs/root ";
cat /dev/null > /var/spool/cron/crontabs/root

echo "rm -rf /var/spool/cron/arjobs/*";
rm -rf /var/spool/cron/atjobs/*
