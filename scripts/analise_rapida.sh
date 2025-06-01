#!/bin/bash

url=$1
clean_url=$(echo $url | sed 's~http[s]*://~~g')

# Remove caracteres problemáticos para nomes de arquivo, como /, :, etc.
safe_name=$(echo "$clean_url" | tr -cd '[:alnum:]._-')

output_file="/app/relatorio_${safe_name}_$(date +%Y%m%d%H%M%S).txt"

{
  echo "=== Relatório de Análise Rápida ==="
  echo "Alvo: $clean_url"
  echo "Data: $(date)"
  echo ""

  echo "== Teste de Ping =="
  ping -c 4 $clean_url || echo "Ping falhou."
  echo ""

  echo "== Varredura de Portas (Nmap) =="
  nmap -Pn -T4 -F $clean_url
  echo ""

  echo "== Informações WHOIS =="
  whois $clean_url 2>/dev/null || echo "Whois não disponível."
  echo ""

  echo "== Headers HTTP =="
  curl -I --max-time 10 $url || echo "Não foi possível obter headers."
  echo ""

  echo "=== Fim do Relatório ==="
} > $output_file

echo "Relatório salvo em: $output_file"
