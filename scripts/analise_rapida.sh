#!/bin/bash

url=$1
clean_url=$(echo $url | sed 's~http[s]*://~~g')

echo "=== Relatório de Análise Rápida ==="
echo "Alvo: $clean_url"
echo "Data: $(date)"
echo ""

# Ping
echo "== Teste de Ping =="
ping -c 4 $clean_url || echo "Ping falhou."
echo ""

# Nmap - portas comuns
echo "== Varredura de Portas (Nmap) =="
nmap -Pn -T4 -F $clean_url
echo ""

# Whois
echo "== Informações WHOIS =="
whois $clean_url 2>/dev/null || echo "Whois não disponível."
echo ""

# Cabeçalhos HTTP
echo "== Headers HTTP =="
curl -I --max-time 10 $url || echo "Não foi possível obter headers."
echo ""

echo "=== Fim do Relatório ==="
