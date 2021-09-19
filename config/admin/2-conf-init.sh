#!/bin/bash

#configuracion de los iptables, para evitar que alguien intente entrar fuera de la maquina
echo "iptables -P INPUT DROP ";
iptables -P INPUT DROP 

echo "iptables -P FORWARD DROP";
iptables -P FORWARD DROP

echo "iptables -P OUTPUT DROP";
iptables -P OUTPUT DROP

#MUESTRA LAS INTEFACES
echo "/sbin/ifconfig";
/sbin/ifconfig
read -p "Ingrese el nombre de la interface: " nameInterface;

#Leyendo las direcciones mac de los clientes
FICHERO='../archivos/list-mac.conf'

if [ -f $FICHERO ]
then
	echo "El fichero $FICHERO existe.";
	while read -r linea
	do
		IN=$linea
		arrIN=(${IN//=/ })
		if [ ${arrIN[0]} == "MAC1" ]; then MAC1=${arrIN[1]}; fi
	    if [ ${arrIN[0]} == "MAC2" ]; then MAC2=${arrIN[1]}; fi
	    if [ ${arrIN[0]} == "MAC3" ]; then MAC3=${arrIN[1]}; fi
	done < $FICHERO
else
   	echo "El fichero $FICHERO no existe, no se puede realizar la configuracion.";
   	exit
fi

#No lo se
insmod sch_htb 2> /dev/null

#Creamos el nodo raíz con tc htb
echo "tc qdisc add dev $nameInterface root handle 1: htb default 0xA";
tc qdisc add dev $nameInterface root handle 1: htb default 0xA



filter_mac() {
    M0=$(echo $1 | cut -d : -f 1)$(echo $1 | cut -d : -f 2)
    M1=$(echo $1 | cut -d : -f 3)$(echo $1 | cut -d : -f 4)
    M2=$(echo $1 | cut -d : -f 5)$(echo $1 | cut -d : -f 6)
    
    # mac aa:aa:aa:aa:aa:aa
    tc filter add dev $nameInterface parent 1: protocol ip prio 5 u32 match u16 0x0800 0xFFFF at -2 match u16 0x${M2} 0xFFFF at -4 match u32 0x${M0}${M1} 0xFFFFFFFF at -8 flowid $2 #matcheamos la mac si es origen
    tc filter add dev $nameInterface parent 1: protocol ip prio 5 u32 match u16 0x0800 0xFFFF at -2 match u32 0x${M1}${M2} 0xFFFFFFFF at -12 match u16 0x${M0} 0xFFFF at -14 flowid $2 #matcheamos la mac si es destino, probablemente esto no sea útil
}

tc class add dev $nameInterface parent 1:1 classid 1:11 htb rate 1Kbit
tc class add dev $nameInterface parent 1:1 classid 1:12 htb rate 1Kbit
tc class add dev $nameInterface parent 1:1 classid 1:13 htb rate 1Kbit

filter_mac $MAC1 1:11
filter_mac $MAC2 1:12
filter_mac $MAC3 1:13

echo "Se han finalizado las configuraciones predeterminadas iniciales...";
