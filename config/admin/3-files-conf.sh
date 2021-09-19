#!/bin/bash

read -p "Ingrese el el minimo de ancho de banda (down): " BWD;
read -p "Ingrese el el maximo de ancho de banda (up): " BWU;

BWG=((BWD+BWU)*1024) #ancho de banda total (bajada y subida) en Kbit
echo "*********************************************"
echo "* El ancho de banda total es de: ${BWG}Kbit *"
echo "*********************************************"

MODE=0;

while [[  $MODE -ne 1 && $MODE -ne 2 ]]
do
	echo ""
	echo "*********************************************"
	echo "*                 Modalidad                 *"
	echo "*********************************************"
	echo "* 1. Estricto                               *"
	echo "*                                           *"
	echo "* 2. Dinamico                               *"
	echo "*********************************************"
	echo ""
	read -p "Ingrese el tipo de modalidad (1 o 2) " MODE;
done



if [ $MODE -eq 2 ]; then CEIL="ceil ${BWG}Kbit"; fi #Cadena que se agregará si es el modo dinámico


FICHERO_USER_BW='../archivos/list-users-bw.conf'

if [ -f $FICHERO_USER_BW ]
then
	echo "El fichero $FICHERO_USER_BW existe."
	while read -r linea
	do
	  #echo "$linea" son 5 parametros, mac,bajada,subida,horainicio,horafin
	  	IN=$linea
		arrIN=(${IN//,/ }) 
	    BWDT=${arrIN[1]}; #porcentaje de ancho de banda de bajada
	    BWUT=${arrIN[2]}; #porcentaje de ancho de banda de subida
	    ((BWTT=(BWD*1024*BWDT/100)+(BWU*1024*BWUT/100))) #cantidad de ancho de banda a dar a la clase en Kbit
	    IFS=":"
	    read -a hora_inicio <<< "${arrIN[3]}" #Dividir 12:14 en 12 y 14
	    read -a hora_fin <<< "${arrIN[4]}"
	    IFS=""
	    #Programar los cambios en el ancho de bandaecho
	    echo "./insertar-crontab.sh ${hora_inicio[1]} ${hora_inicio[0]} $BWTT ${arrIN[0]} $CEIL";
	    ./insertar-crontab.sh ${hora_inicio[1]} ${hora_inicio[0]} $BWTT ${arrIN[0]} $CEIL
	    echo "./insertar-crontab.sh ${hora_fin[1]} ${hora_fin[0]} 0 ${arrIN[0]}";
	    ./insertar-crontab.sh ${hora_fin[1]} ${hora_fin[0]} 0 ${arrIN[0]}
	done < $FICHERO_USER_BW
else
   	echo "El fichero $FICHERO no existe, no se puede realizar la configuracion."
   	exit
fi


#LEYENDO EL ARCHIVO DE TEXTO USUARIO-PROTO.CONF-----------------------------------------------
echo "Leyendo el archivo de texto users-protocol.conf---------------------------------------------------------------------------------------------------------------"

FICHERO_USER_PROTOCOL='../archivos/users-protocol.conf'

if [ -f $FICHERO_USER_PROTOCOL ]
then
	while read -r linea
	do
	    IFS=','
	    read -a parametros <<< "$linea"
	    if [ ${#parametros[@]} -eq 4 ]; then #Serian 4 parametros mac,protocolo,horainicio,horafin
	      ./iptable-command.sh 0 icmp ${parametros[0]} ${parametros[2]} ${parametros[3]}
	    fi

	    if [ ${#parametros[@]} -eq 5 ]; then #Serian 5 parametros mac,protocolo,puerto(s),horainicio,horafin
	      IFS=':'
	      read -a puertos <<< "${parametros[2]}"
	      IFS=""
	      if [ ${#puertos[@]} -eq 2 ]; then
	        ./iptable-command.sh 1 ${parametros[1]} ${parametros[0]} ${parametros[3]} ${parametros[4]} ${puertos[0]} ${puertos[1]}
	      else 
	        ./iptable-command.sh 1 ${parametros[1]} ${parametros[0]} ${parametros[3]} ${parametros[4]} ${parametros[2]}
	      fi

	    fi
	done < $FICHERO_USER_PROTOCOL
else
   	echo "El fichero $FICHERO_USER_PROTOCOL no existe, no se puede realizar la configuracion."
   	exit
fi
echo

echo