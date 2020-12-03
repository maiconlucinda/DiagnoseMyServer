#!/bin/bash
#
#   1 - Contagem de nucleos
#   2 - Load Average
#   3 - Valida Carga de CPU
#
#   Versao 3.0  rev3   pt_BR
#==================================================

  nucleos=$(awk -F: '/processor/ {core++} END {print core}' /proc/cpuinfo)
   loadaverage=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
   echo -e $verde "Nucleos....................:" $resetacor $nucleos;

   cmin=$(echo $loadaverage | awk '{print $1}' | cut -f1 -d, | cut -d'.' -f1)
   dmin=$(echo $loadaverage | awk '{print $2}' | cut -f1 -d, | cut -d'.' -f1)
   qmin=$(echo $loadaverage | awk '{print $3}' | cut -f1 -d, | cut -d'.' -f1)

   echo -e $verde "Load Average...............:" $resetacor $loadaverage;
   echo '';
   if [ "$cmin" -gt "$nucleos" ]; then
    echo -e $vermelho "Processador sobrecarregado nos ultimos 5 minutos";
   else
    echo -e $verde "Processador nao esta sobrecarregado nos ultimos 5 minutos";
   fi

   if [ "$dmin" -gt "$nucleos" ]; then
    echo -e $vermelho "Processador sobrecarregado nos ultimos 10 minutos";
   else
    echo -e $verde "Processador nao esta sobrecarregado nos ultimos 10 minutos";
   fi

   if [ "$qmin" -gt "$nucleos" ]; then
    echo -e $vermelho "Processador sobrecarregado nos ultimos 15 minutos";
   else
    echo -e $verde "Processador nao esta sobrecarregado nos ultimos 15 minutos";
   fi
