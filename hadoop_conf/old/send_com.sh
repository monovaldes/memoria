#!/bin/bash
# mucho lusho hacerlo con getopts para tan pocas opciones XD
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
	echo "usar $0 COMPUTADOR(ES) [-f] \"COMANDO\""
	exit 0
fi
SSH1="ssh -o ConnectTimeout=5 hadoop@"
SSH2="trollface"
comando=$2
if [ $# = 3 ]; then
	if [ $2 = '-f' ]; then
		SSH1="ssh -o ConnectTimeout=5 -f hadoop@"
		SSH2="&"
		comando=$3
	elif [ $3 = '-f' ]; then
		SSH1="ssh -o ConnectTimeout=5 -f hadoop@"
		SSH2="&"
	fi
fi
if [ -f $1 ]; then
	for pc in $(grep -v '^#' $1)
        do
                #echo "Enviando al $pc el comando: $comando"
                #echo "$pc"
                #echo "$SSH1$pc \"$comando\" $SSH2"
	        if [ $SSH2 = "&" ]; then
			echo "$pc"
			$SSH1$pc "$comando" &
		else
			echo "$pc"
			$SSH1$pc "$comando"
			echo ""
		fi
		#echo ""
	done
	exit 0
else
	ssh hadoop@$1 "$2"
        exit 0
fi
echo "Uta no hice nada 8("
echo "usar $0  COMPUTADORES(ES) [-f] \"COMANDO\""
