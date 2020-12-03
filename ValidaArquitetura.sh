#!/bin/bash
#
#   1 - Modelo do Processador
#   2 - Arquitetura do Kernel: 32 ou 64 bits
#   3 - Arquitetura do processador: <flags> 32 ou 64 bits
#
#   Versao 3.0   Rev3   pt_BR
#===============================================================================


   nomeproc=$(cat /proc/cpuinfo | grep 'model name' | uniq | awk '{print $4 $5 $6 $7}');
    echo -e $verde "Modelo do Processador......: $resetacor $nomeproc";

   arquiteturaKERNEL=$(getconf LONG_BIT);
   if [ "$arquiteturaKERNEL" -gt 32 ]; then
    echo -e $verde "Arquitetura do Kernel......: $resetacor $arquiteturaKERNEL bits";
   else
    echo -e $verde "Arquitetura do Kernel......: $vermelho $arquiteturaKERNEL bits (SISTEMA INSTALADO COM KERNEL 32 BITS)" $resetacor;
   fi

   arquiteturaPROC=$(grep -o -w 'lm' /proc/cpuinfo | sort -u);
   if [ "$arquiteturaPROC" == "lm" ]; then
    echo -e $verde "Arquitetura do Processador.: $resetacor $arquiteturaPROC";
  else $verd
    echo -e $verde "Arquitetura do Processador.: $vermelho tm (PROCESSADOR NAO SUPORTA 64 BITS)" $resetacor;
   fi
