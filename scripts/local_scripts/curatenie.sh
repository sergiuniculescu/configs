#!/bin/bash

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)


if [ $USER != root ]; then
  echo -e "Eroare: trebuie să fiți administrator"
  echo -e "Ieșire..."
  exit 0
fi

echo -e "Ștergere apt cache..."
aptitude clean

echo -e "Ștergere fișiere de configurare vechi..."
sudo aptitude purge $OLDCONF

echo -e "Ștergere kernele vechi..."
sudo aptitude purge $OLDKERNELS

echo -e "Se golesc coșurile de gunoi..."
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e "Curățenia e gata!"
