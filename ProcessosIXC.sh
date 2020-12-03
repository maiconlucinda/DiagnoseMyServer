#!/bin/bash
#
#   1 - Valida quantos processos por servico estao rodando
#   2 - Valida se os servicos estao rodando
#   3 - Identifica os top 5 processos consumidores de RAM e CPU
#
#   Versao 3.0  Rev3   pt_BR
#===============================================================================

function Top5(){
 top -b -n1 -o $indice | sort -k1 -r -n | head -5 >/tmp/procs
   i=0
   while read procs; do
    if [ $indice == "%CPU" ]; then
     usorecurso=`echo "$procs" | awk '{print $9}' | cut -d. -f1`
    else
     usorecurso=`echo "$procs" | awk '{print $10}' | cut -d. -f1`
    fi
    if [ $usorecurso -gt $compara ]; then
     echo -e $vermelho "Processo $i: $procs" $resetacor;
    else
     echo -e $verde "Processo $i: $procs" $resetacor;
    fi
   i=$(($i + 1))
   done </tmp/procs;
}

   ProcPhp=$(ps aux | grep php-fpm | wc -l)
   ProcNode=$(ps aux | grep node | wc -l)
   ProcMysql=$(ps aux | grep mysql | wc -l)
   ProcFreeradius=$(ps aux | grep radius | wc -l)
   ProcFail2ban=$(ps aux | grep fail2 | wc -l)
   ProcNginx=$(ps aux | grep nginx | wc -l)

   ExprPhp=$(expr $ProcPhp - 1)
   ExprNode=$(expr $ProcNode - 1)
   ExprMysql=$(expr $ProcMysql - 1)
   ExprFreeradius=$(expr $ProcFreeradius - 1)
   ExprFail2ban=$(expr $ProcFail2ban - 1)
   ExprNginx=$(expr $ProcNginx - 1)

   ServPhp=$(systemctl status php7.* | grep "Active:" | awk '{print $2 $3}')
   ServNginx=$(systemctl status nginx | grep "Active:" | awk '{print $2 $3}')
   ServFreeradius=$(systemctl status freeradius | grep "Active:" | awk '{print $2 $3}')
   ServMysql=$(systemctl status mysql| grep "Active:" | awk '{print $2 $3}')
   ServFail2ban=$(systemctl status fail2ban | grep "Active:" | awk '{print $2 $3}')
   ServCrontab=$(systemctl status cron | grep "Active:" | awk '{print $2 $3}')

   echo -e $verde "php-fpm....................:$resetacor" $ExprPhp;
   echo -e $verde "Node.......................:$resetacor" $ExprNode;
   echo -e $verde "Mysql......................:$resetacor" $ExprMysql;
   echo -e $verde "Freeradius.................:$resetacor" $ExprFreeradius;
   echo -e $verde "Fail2ban...................:$resetacor" $ExprFail2ban;
   echo -e $verde "Nginx......................:$resetacor" $ExprNginx;
   echo '';


   echo -e $azulG"Status dos servicos..." $resetacor

   if [ $ServPhp == "active(running)" ]; then
    echo -e $verde "PHP........................:$resetacor $ServPhp";
   else
    echo -e $verde "PHP........................:$vermelho $ServPhp ARRUMAR PHP$resetacor";
   fi

   if [ $ServNginx == "active(running)" ]; then
    echo -e $verde "Nginx......................:$resetacor $ServNginx";
   else
    echo -e $verde "Nginx......................:$vermelho $ServNginx ARRUMAR NGINX$resetacor";
   fi

   if [ $ServMysql == "active(running)" ]; then
    echo -e $verde "Mysql......................:$resetacor $ServMysql";
   else
    echo -e $verde "Mysql......................:$vermelho $ServMysql ARRUMAR MYSQL$resetacor";
   fi

   if [ $ServFreeradius == "active(running)" ]; then
    echo -e $verde "Freeradius.................:$resetacor $ServFreeradius";
   else
    echo -e $verde "Freeradius.................:$vermelho $ServFreeradius ARRUMAR FREERADIUS$resetacor";
   fi

   if [ $ServFail2ban == "active(running)" ]; then
    echo -e $verde "Fail2ban...................:$resetacor $ServFail2ban";
   else
    echo -e $verde "Fail2ban...................:$vermelho $ServFail2ban ARRUMAR FAIL2BAN$resetacor";
   fi

   if [ $ServCrontab == "active(running)" ]; then
    echo -e $verde "Crontab....................:$resetacor $ServCrontab";
   else
    echo -e $verde "Crontab....................:$vermelho $ServCrontab ARRUMAR CRONTAB$resetacor";
   fi


echo ''
echo -e $verdeG"uso CPU" $resetacor
indice='%CPU'
compara=50
Top5
echo ''
echo -e $verdeG"uso MEM" $resetacor
indice='%MEM'
compara=25
Top5
