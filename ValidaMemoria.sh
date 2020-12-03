#!/bin/bash
#
#  1 - Coleta informacoes de uso de memoria
#  2 - Exibe % de uso da RAM
#
#  Versao 2.0   Rev1   pt_BR
#===============================================================================
MemoriaTotal=0
MemoriaLivre=0
i=0

function Porcentagem(){
  porcentagem1=$(expr 100 \* "$megas")
  porcentagem2=$(expr "$porcentagem1" \/ "$MemoriaTotal" )
}

egrep 'Mem|Cache' /proc/meminfo | grep -v "Swap" > /tmp/ramusage
MEMORIA[0]=$verde"Memoria Total..............:$resetacor"
MEMORIA[1]=$verde"Memoria Livre..............:$resetacor"
MEMORIA[2]=$verde"Memoria Disponivel.........:$resetacor"
MEMORIA[3]=$verde"Memoria Cache..............:$resetacor"

while read linha; do
quantia=$(echo "$linha" | awk '{print $2}')
megas=$(expr $quantia \/ 1024)

while [ "$MemoriaLivre" == 1 ]; do
  MemoriaLivre="$megas"
done

while [ "$MemoriaTotal" == 0 ]; do
  MemoriaTotal="$megas"
  MemoriaLivre=1
done

Porcentagem

 echo -e " "${MEMORIA[$i]} "$megas Mbs    $porcentagem2%"

i=$(($i + 1))
done </tmp/ramusage;

MemoriaUso=$(expr "$MemoriaTotal" - "$MemoriaLivre")
megas="$MemoriaUso"

Porcentagem

if [ "$porcentagem2" -gt 70 ]; then
 echo -e  $verde "Memoria em uso.............:$resetacor" $MemoriaUso "Mbs   $vermelhoG $porcentagem2% (ALTO USO DE MEMORIA)" $resetacor;
elif [ "$porcentagem2" -lt 40 ]; then
 echo -e  $verde "Memoria em uso.............:$resetacor" $MemoriaUso "Mbs   $verdeG $porcentagem2%" $resetacor;
else
 echo -e  $verde "Memoria em uso.............:$resetacor" $MemoriaUso "Mbs   $amareloG $porcentagem2%" $resetacor;
fi
