
IN="bla@some.com;john@home.com"
arrIN=(${IN//;/ }) 

for i in "${arrIN[@]}"
do
	echo $i;
done


FICHERO='../archivos/list-mac.conf'

if [ -f $FICHERO ]
then
	echo "El fichero $FICHERO existe."
	while read -r linea
	do
		IN=$linea
		arrIN=(${IN//;/ }) 
		if [ ${arrIN[0]} == "MAC1" ]; then MAC1=${arrIN[1]}; fi
	    if [ ${arrIN[0]} == "MAC2" ]; then MAC2=${arrIN[1]}; fi
	    if [ ${arrIN[0]} == "MAC3" ]; then MAC3=${arrIN[1]}; fi
	done < $FICHERO
else
   	echo "El fichero $FICHERO no existe, no se puede realizar la configuracion."
   	exit
fi


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

if [ $MODE -eq 1 ]; then echo "El modo de configuración es Estricto."; fi
if [ $MODE -eq 2 ]; then echo "El modo de configuración es Dinámico."; fi



