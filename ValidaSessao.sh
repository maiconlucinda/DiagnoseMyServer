#!/bin/bash
#
#   1 - Valida e difere a sessao de quem executa o script
#   2 - Mostra quantos usuarios estao logados
#
#   Versao 2.0   Rev3   pt_BR
#===============================================================================

   usuario=$(whoami)
   sessao=$(tty | egrep pts\/[0-9] | awk -F/ '{print $4}')
   n=1

   w | grep "$usuario" >/tmp/who;
   while read line; do
   ValidaUsuario=$(echo "$line" | awk '{print $2}' | awk -F 'pts/' '{print $2}')
   n=$((n + 1))
    if [ "$sessao" != "$ValidaUsuario" ]; then
     echo -e $vermelho "Outra Sessao  $n: $line" $resetacor;
    else
     echo -e $verde "Sua Sessao    $n: $line" $resetacor;
    fi
   done </tmp/who;
