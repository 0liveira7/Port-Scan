#!/bin/bash

#portknock-local.sh - 0liveira7

if [ "$1" == "" ]; then
    echo "Modo de uso: $0 REDE"
    echo "Exemplo: $0 172.16.1.0"
    exit 1
fi

rede_local="$1"

# Verifica se o prefixo de IP é válido
if [[ ! $rede_local =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "Erro: Prefixo de IP inválido. Certifique-se de fornecer um prefixo de IP válido, Exemplo: 172.16.1.0"
    exit 1

fi

# Portas a serem usadas no port knocking

portas=("20" "21" "22" "23" "25" "53" "80" "110" "143" "443")

# Função para realizar o port knocking em um IP
realizar_port_knocking() {

    local ip="$1"
    for porta in "${portas[@]}"; do

        if sudo hping3 -c 1 -S -p "$porta" "$ip" >/dev/null 2>&1; then
            echo "Port knocking realizado para o IP: $ip na porta: $porta"
            sleep 1
            curl -s "http://$ip:$porta" && echo -e "\n"

        fi
    done

}
echo "Executando o Port Knocking..."
echo "Batendo nas portas..."


# Loop para percorrer a faixa de IPs e realizar o port knocking em cada um
for i in {1..254}; do
    ip="$rede_local.$i"
    realizar_port_knocking "$ip"
done

# Concluído
echo "Port knocking concluído para a rede local $rede_local nas portas ${portas[@]}."

