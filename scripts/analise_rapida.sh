#!/bin/bash
URL=$1
echo "🔍 Whois:"
whois $URL
echo "-----------------------------"
echo "🌐 Nmap:"
nmap -Pn $URL
echo "-----------------------------"
echo "🛡️ Nikto:"
nikto -h $URL
