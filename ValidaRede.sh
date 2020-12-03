#!/bin/bash
#
#   1 - IP interno
#   2 - IP externo
#   3 - Servidores DNS
#
#   Versao 1.0   Rev3   pt_BR
#===============================================================================

   ping -c 1 45.174.128.1 &>/dev/null && echo -e $verde "Internet...................: $resetacor Conectado" || echo -e $vermelho "Internet...........: Sem internet $resetacor"
   ping -c 1 sistema.ixcsoft.com.br &>/dev/null && echo -e $verde "DNS........................: $resetacor Resolvendo" || echo -e $vermelho "DNS NAO RESOLVE $resetacor"

   ipinterno=$(hostname -I)
   echo -e $verde "IP Interno.................:" $resetacor $ipinterno;
   ipexterno=$(curl -s ipecho.net/plain;echo)
   echo -e $verde "IP Externo.................:" $resetacor $ipexterno;
   nameservers=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}')
   echo -e $verde "Servidores DNS.............:" $resetacor $nameservers;
