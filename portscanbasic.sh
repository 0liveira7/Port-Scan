#!/bin/bash

#portscanbasic.sh - 0liveira

#Caso não colocar um argumento, ele irá mostrar o modelo.
if [ "$1" == "" ]
then
	echo "Modo de uso: REDE PORTA"
	echo "Exemplo: 172.16.1 80"
elif [ "$2" == "" ]
then

	echo "Modo de uso: REDE PORTA"
	echo "Exemplo: 172.16.1 80"

else
for ip in {1..254}
do
hping3 -S -p $2 -c 1 $1.$ip 2> /dev/null | grep "flags=SA" | cut -d " " -f 2 | cut -d "=" -f 2;
done
fi