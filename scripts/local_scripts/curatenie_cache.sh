#!/bin/sh

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
exit 0
