#!/bin/bash
if [ $# -lt 3  ]; then
	echo "Solo para copiar archivos a los demas computadores"
	echo "$0 COMPUTADOR(ES) ARCHIVO DESTINO"
	echo ""
	echo "Ejemplo:"
	echo "$0 lpa-pc01 ../../prueba ."
	echo ""
	echo "Seria lo mismo que hacer:"
	echo "scp ../../prueba root@lpa-pc01"
	exit 0
fi
if [ -f $2 ]; then
	DESTINO_FINAL=$3
	if [ -f $1 ]; then
        	for pc in $(cat $1 | grep -v "^#")
		do
			echo "Copiando al $pc"
			DESTINO="$USER@$pc:$3"
			scp  $2 $DESTINO
		done
        	exit 0
else
        	echo "Copiando al $1"
	        scp  $2 $USER@$1:$3
        	exit 0
	fi
else
	echo "el archivo $2 no existe"
	exit 0
fi
echo "No hice ni una wea..."
