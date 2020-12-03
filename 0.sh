#!/bin/bash
#
#
#
# ARRUMAR CERTIFICADOS
# ARRUMAR NGINX (FORCE SSL)
# VALIDA JAVA RODANDO
#===============================================================================

resetacor=$(tput sgr0)
vermelho='\E[31m'
vermelhoG='\E[31;1m'
verde='\E[32m'
verdeG='\E[32;1m'
amarelo='\E[33m'
amareloG='\E[33;1m'
azul='\E[34m'
azulG='\E[34;1m'

echo -e $azulG"REDE..." $resetacor;
source ValidaRede.sh && echo '';

echo -e $azulG"SISTEMA OPERACIONAL..." $resetacor;
source ValidaDebian.sh && echo '';

echo -e $azulG"VIRTUALIZACAO..." $resetacor;
source ValidaVirtualizacao.sh && echo '';

echo -e $azulG"PROCESSADOR..."
source ValidaArquitetura.sh && echo '';
source MonitoraCPU.sh && echo '';

echo -e $azulG"MEMORIA RAM... " $resetacor;
source ValidaMemoria.sh && echo '';

echo -e $azulG"DISCO..."$resetacor;
source ValidaDisco.sh && echo '';
source VerificaEscrita.sh && echo '';

echo -e $azulG"PROCESSOS..."$resetacor;
source ProcessosIXC.sh && echo '';
source ValidaPHP.sh && echo '';

echo -e $verdeG"USUARIOS LOGADOS... " $resetacor;
source ValidaSessao.sh && echo '';


rm /tmp/{osrelease,who,diskusage,disks,procs,ramusage}
