#!/bin/bash

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)


if [ $USER != root ]; then
  echo -e "Error: must be root"
  echo -e "Exiting..."
  exit 0
fi

echo -e "Cleaning apt cache..."
aptitude clean
apt-get autoclean
apt-get autoremove

echo -e "Removing old config files..."
sudo aptitude purge $OLDCONF

echo -e "Removing old kernels..."
sudo aptitude purge $OLDKERNELS

echo -e "Emptying every trashes..."
rm -rf /home/*/.local/share/Trash/*/** &> /dev/null
rm -rf /root/.local/share/Trash/*/** &> /dev/null

echo -e "BEFORE EMPTY CACHES"
free
echo 3 > /proc/sys/vm/drop_caches
echo 0 > /proc/sys/vm/drop_caches
msg="Cannot write swap back to RAM...\nNot enough memory - bye..."
mem=`free -m|grep Mem:|awk '{print $4}'`
swap=`free -m|grep Swap:|awk '{print $3}'`
test $mem -lt $swap && echo -e $msg && exit 1
echo -e "\nOutput of free before moving swap:" &&
free &&
swapoff -a && swapon -a &&
echo -e "\nOutput of free after:" &&
free &&
echo -e "Script Finished!"
exit 0


