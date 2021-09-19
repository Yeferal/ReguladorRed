
# IN="bla@some.com;john@home.com"
# arrIN=(${IN//;/ }) 

# for i in "${arrIN[@]}"
# do
# 	echo $i;
# done


# FICHERO='../archivos/list-mac.conf'

# if [ -f $FICHERO ]
# then
# 	echo "El fichero $FICHERO existe."
# 	while read -r linea
# 	do
# 		IN=$linea
# 		arrIN=(${IN//=/ })
# 		if [ ${arrIN[0]} == "MAC1" ]; then MAC1=${arrIN[1]}; fi
# 		if [ ${arrIN[0]} == "MAC2" ]; then MAC2=${arrIN[1]}; fi
# 		if [ ${arrIN[0]} == "MAC3" ]; then MAC3=${arrIN[1]}; fi
# 	done < $FICHERO
# else
#    	echo "El fichero $FICHERO no existe, no se puede realizar la configuracion."
#    	exit
# fi
# echo $MAC1;
# echo $MAC2;
# echo $MAC3;

# MODE=0;

# while [[  $MODE -ne 1 && $MODE -ne 2 ]]
# do
# 	echo ""
# 	echo "*********************************************"
# 	echo "*                 Modalidad                 *"
# 	echo "*********************************************"
# 	echo "* 1. Estricto                               *"
# 	echo "*                                           *"
# 	echo "* 2. Dinamico                               *"
# 	echo "*********************************************"
# 	echo ""
# 	read -p "Ingrese el tipo de modalidad (1 o 2) " MODE;
# done

# if [ $MODE -eq 1 ]; then echo "El modo de configuración es Estricto."; fi
# if [ $MODE -eq 2 ]; then echo "El modo de configuración es Dinámico."; fi

space=' ';
macname="$1";
mac1="MAC1";
mac2="MAC2";
mac3="MAC3";

echo "$macname"="$mac1"

if [[ $macname == "MAC1" ]]; then
    echo "1";
else
	echo "no es 1";
fi

if [[ $macname == "MAC2" ]]; then
    echo "2";
fi

if [[ $macname == "MAC3" ]]; then
    echo "3";
fi


echo "$macname|";


