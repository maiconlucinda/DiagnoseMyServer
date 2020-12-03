#!/bin/bash
#
#   1 - Valida se o Disco e HDD ou SSD
#
#
#   Versao 1.0   Rev3   pt_BR
#===============================================================================

   disco=$(ls /sys/block/ | grep sd* | grep -v sr* > /tmp/disks)
   while read linha; do
   SSD=$(cat /sys/block/$linha/queue/rotational)
   n=$((n + 1))
   if [ "$SSD" == "0" ]; then
    echo -e $verde "DISCO $linha:$verde SSD" $resetacor;
   else
    echo -e $verde "DISCO $linha:$vermelho HDD" $resetacor;
   fi
   done </tmp/disks;
   df -h  >/tmp/diskusage
   echo -e $verde "Uso de Disco :" $resetacor
   cat /tmp/diskusage
