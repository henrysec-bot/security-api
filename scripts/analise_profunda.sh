#!/bin/bash

url=$1
clean_url=$(echo $url | sed 's~http[s]*://~~g')

echo "=== Relatório de Análise Profunda ==="
echo "Alvo: $clean_url"
echo "Data: $(date)"
echo ""

# Ping
echo "== Teste de Ping =="
ping -c 4 $clean_url || echo "Ping falhou."
echo ""

# Varredura completa de portas e serviços
echo "== Nmap - Varredura Completa de Portas =="
nmap -Pn -T4 -A $clean_url
echo ""

# Nikto - varredura de vulnerabilidades HTTP
echo "== Nikto - Vulnerabilidades HTTP =="
nikto -h $url
echo ""

# WhatWeb - identificação de tecnologias
echo "== WhatWeb - Tecnologias Utilizadas =="
whatweb $url
echo ""

# Whois
echo "== WHOIS =="
whois $clean_url 2>/dev/null || echo "Whois não disponível."
echo ""

# Cabeçalhos HTTP
echo "== Headers HTTP =="
curl -I --max-time 10 $url || echo "Não foi possível obter headers."
echo ""

# Traceroute
echo "== Traceroute =="
traceroute $clean_url || echo "Traceroute não disponível."
echo ""

echo "=== Fim da Análise Profunda ==="
