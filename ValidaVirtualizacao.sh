#!/bin/bash
#
#   1 - Valida se o HOST e virtualizado ou nao
#   2 - Valida qual o virtualizador/chassis a maquina esta usando
#
#   Versao 3.0   Rev3   pt_BR
#===============================================================================
   chassi=$(systemd-detect-virt)
   fisico=$(dmidecode -s chassis-type)

   if [ "$chassi" == "none" ]; then
    if [ "$fisico" == "Notebook" ]; then
     echo -e $verde "Chassis....................:" $resetacor $fisico $vermelho"MAQUINA INAPROPRIADA" $resetacor;
    else
     echo -e $verde "Chassis....................:" $resetacor $fisico $amarelo"MAQUINA FISICA" $resetacor;
    fi
  else
   if [ "$chassi" == "qemu" ]; then
    echo -e $verde "Chassis....................:" $resetacor $chassi $verde"(vm PROXMOX)" $resetacor;
   elif [ "$chassi" == "vmware" ]; then
    echo -e $verde "Chassis....................:" $resetacor $chassi $vermelho"(vm VMWARE)" $resetacor;
   elif [ "$chassi" == "xen" ]; then
    echo -e $verde "Chassis....................:" $resetacor $chassi $vermelho"(vm XenServer/Citrix)" $resetacor;
   elif [ "$chassi" == "microsoft" ]; then
    echo -e $verde "Chassis....................:" $resetacor $chassi $vermelho"(vm Microsoft)" $resetacor;
   elif [ "$chassi" == "lxc" ]; then
    echo -e $verde "Chassis....................:" $resetacor $chassi $vermelho"(container PROXMOX) PODE TER COMPETICAO" $resetacor;
   elif [ "$chassi" == "docker" ]; then
    echo -e $verde "Chassis....................:" $resetacor $chassi $vermelho"(container DOCKER) PODE TER COMPETICAO" $resetacor;
   else
    echo -e $verde "Chassis....................:" $resetacor $chassi"(vm Bochs VALIDAR)" $resetacor;
   fi
   fi
