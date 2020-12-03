#!/bin/bash
#
#   1 - Testa escrita em disco
#   2 - Valida velocidade do disco
#   3 - Gera media de escrita
#
#   Versao 2.0   Rev3   pt_BR
#===============================================================================

function TestEscrita(){
  (LANG=C dd if=/dev/zero of=escrita_$$ bs=64k count=16k conv=fdatasync && rm -f escrita* ) 2>&1 | awk -F, '{io=$NF} END { print io}' | sed 's/^[ \t]*//;s/[ \t]*$//'
}

   echo -e $amarelo"Testando escrita, pode demorar um pouco, aguarde..."$resetacor;
   escrita1=$( TestEscrita )
   Escrita1Val=$( echo $escrita1 | awk -F'.' '{print $1}' | cut -d' ' -f1 )
   if [ "$Escrita1Val" -lt "100" ]; then
    echo -e $verde "Velocidade E/S(1): $vermelho $escrita1" $resetacor
   else
    echo -e $verde "Velocidade E/S(1): $escrita1" $resetacor
   fi
   escrita2=$( TestEscrita )
   Escrita2Val=$( echo $escrita2 | awk -F'.' '{print $1}' | cut -d' ' -f1 )
   if [ "$Escrita2Val" -lt "100" ]; then
    echo -e $verde "Velocidade E/S(2): $vermelho $escrita2" $resetacor
   else
    echo -e $verde "Velocidade E/S(2): $escrita2" $resetacor
   fi
   escrita3=$( TestEscrita )
   Escrita3Val=$( echo $escrita3 | awk -F'.' '{print $1}' | cut -d' ' -f1 )
   if [ "$Escrita3Val" -lt "100" ]; then
    echo -e $verde "Velocidade E/S(3): $vermelho $escrita3" $resetacor
   else
    echo -e $verde "Velocidade E/S(3): $escrita3" $resetacor
   fi
   soma=$(expr "$Escrita1Val" + "$Escrita2Val" + "$Escrita3Val")
   media=$(expr $soma / 3)
   if [ $media -lt "100" ]; then
    echo -e $verde "Media de escrita : $vermelho $media.0 MB/s (LENTIDAO NA ESCRITA)" $resetacor;
   else
    echo -e $verde "Media de escrita :$verde $media.0 MB/s" $resetacor;
   fi
