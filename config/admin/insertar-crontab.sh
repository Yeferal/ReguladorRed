INTERFACE=enp0s8

macname="$4";

# 12:15
if [[ $macname == "MAC1" ]]; then
    echo "echo \"/sbin/tc class change dev $INTERFACE parent 1:1 classid 1:11 htb rate ${3}Kbit $5\" | at $2:$1 " >> script.sh
fi
if [[ $macname == "MAC2" ]]; then
    echo "echo \"/sbin/tc class change dev $INTERFACE parent 1:1 classid 1:12 htb rate ${3}Kbit $5\" | at $2:$1 " >> script.sh
fi
if [[ $macname == "MAC3" ]]; then
    echo "echo \"/sbin/tc class change dev $INTERFACE parent 1:1 classid 1:13 htb rate ${3}Kbit $5\" | at $2:$1 " >> script.sh
fi
