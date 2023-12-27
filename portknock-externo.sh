#!/bin/bash

# portknock-externo.sh - 0liveira7

# Solicita ao usuário para digitar o endereço IP ou domínio do servidor
read -p "Digite o endereço IP ou domínio do servidor: " servidor

echo "# Identificando IP/Domínio..."
	sleep 2
echo "# Batendo nas portas..."

# Portas a serem usadas no port knocking
portas=("20" "21" "22" "23" "25" "53" "80" "110" "143" "443")

# Loop para enviar os pacotes para as portas
for porta in "${portas[@]}"; do
    sudo hping3 -c 1 -S -p "$porta" "$servidor" >/dev/null 2>&1
    sleep 1
done

# Concluído
echo "Port knocking concluído para o servidor $servidor nas portas ${portas[@]}."
