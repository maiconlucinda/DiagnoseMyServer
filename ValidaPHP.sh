#!/bin/bash
#
#   1 - Valida se precisa arrumar children
#   2 - Corrige
#
#   Versao 2.0   Rev2   pt_BR
#===============================================================================

tail -n5 /var/log/php7.*-fpm.log > /tmp/phplog
increase=$(cat /tmp/phplog | awk {'print $12'} | grep increase | sort -u)
if [ "$increase" == "increase" ]; then
  echo -e $vermelho "Precisa ajustar configuracao do PHP";
  echo -e $azulG "Deseja corrigir o erro? s/n"
  while :
  do
    read decisao
    case $decisao in
      s)
        maxchildren=$(cat /etc/php/7.*/fpm/pool.d/www.conf | grep pm.max_children | awk '{print $3}')
        startserver=$(cat /etc/php/7.*/fpm/pool.d/www.conf | grep pm.start_servers | awk '{print $3}')
        minspareserver=$(cat /etc/php/7.*/fpm/pool.d/www.conf | grep pm.min_spare_servers | awk '{print $3}')
        maxspareserver=$(cat /etc/php/7.*/fpm/pool.d/www.conf | grep pm.max_spare_servers | awk '{print $3}')

        AumentaMaxChildren=$(expr "$maxchildren" \* 2)
        AumentaStartServer=$(expr "$startserver" \* 2)
        AumentaMinSpareServer=$(expr "$minspareserver" \* 2)
        AumentaMaxSpareServer=$(expr "$maxspareserver" \* 2)

        sed -i "s/pm.max_children = $maxchildren/pm.max_children = $AumentaMaxChildren/g" /etc/php/7.*/fpm/pool.d/www.conf
        sed -i "s/pm.start_servers = $startserver/pm.start_servers = $AumentaStartServer/g" /etc/php/7.*/fpm/pool.d/www.conf
        sed -i "s/pm.min_spare_servers = $minspareserver/pm.min_spare_servers = $AumentaMinSpareServer/g" /etc/php/7.*/fpm/pool.d/www.conf
        sed -i "s/pm.max_spare_servers = $maxspareserver/pm.max_spare_servers = $AumentaMaxSpareServer/g" /etc/php/7.*/fpm/pool.d/www.conf

        systemctl restart php7.*-fpm.service
      ;;
      n)
        echo -e $amarelo "Precisa ajustar ou o servidor vai ficar lento!"
        break
      ;;
      *)
        echo -e $amarelo "SUAS OPCOES SAO $vermelhoG s $amarelo OU $vermelhoG n$amarelo. Tente novamente!"
      ;;
    esac
  done
else
  echo -e $resetacor $verde "Nao precisa ajustar configuracao do PHP";
fi
