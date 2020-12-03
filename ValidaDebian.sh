#!/bin/bash
#
#   1 - Nome do SO
#   2 - Versao do SO
#   3 - Versao Kernel
#
#   Versao 2.0   Rev4   pt_BR
#===============================================================================

   cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' >/tmp/osrelease
   nome=$(cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\" | awk '{print $1}')
   vers=$(cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\" | awk '{print $1}')

   if [ "$nome" == "Debian" ]; then
    echo -e $verde "Nome.......................: "$resetacor $nome;
   else
    echo -e $vermelho "Nome.......................: "$resetacor $vermelho "$nome NAO E DEBIAN" $resetacor;
   fi

   if [ "$vers" -eq 9 ]; then
    echo -e $verde "Versao.....................: " $resetacor"$vers (Stretch) $vermelho FAZER UPGRADE" $resetacor;
   else
    echo -e $verde "Versao.....................: " $resetacor"$vers (Buster)" $resetacor;
   fi
    echo -e $verde "Hostname...................:" $resetacor $HOSTNAME $resetacor;

   versaokernel=$(cat /proc/sys/kernel/version | awk '{print $4}')
    echo -e $verde "Kernel.....................:" $resetacor $versaokernel;
    #echo '';
