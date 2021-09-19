INTERFACE=enp6sO

macname="$5";

# 12:15
if [[ $macname == "MAC1" ]]; then
    echo "$1 $2 * * * /sbin/tc class change dev $INTERFACE parent 1:1 classid 1:11 htb rate ${3}Kbit $5" >> /var/spool/cron/crontabs/root
fi
if [[ $macname == "MAC2" ]]; then
    echo "$1 $2 * * * /sbin/tc class change dev $INTERFACE parent 1:1 classid 1:12 htb rate ${3}Kbit $5" >> /var/spool/cron/crontabs/root
fi
if [[ $macname == "MAC3" ]]; then
    echo "$1 $2 * * * /sbin/tc class change dev $INTERFACE parent 1:1 classid 1:13 htb rate ${3}Kbit $5" >> /var/spool/cron/crontabs/root
fi
