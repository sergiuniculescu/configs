#!/bin/sh

fakedb=/dev/shm/fakepacdb

pkgs=$(pacman --dbpath "$fakedb" -Qqu | wc -l)
aurpkgs=$(cower -u 2> /dev/null | wc -l)

unset msg1
unset msg2
unset packages

if [[ ${pkgs} -gt 0 ]]; then
msg1=" ${pkgs} in pacman"
else msg1="0 in pacman"
fi 

if [[ ${aurpkgs} -gt 0 ]]; then
msg2=" ${aurpkgs} in AUR"
else msg2="0 in AUR"
fi 

let packages=${pkgs}+${aurpkgs}

if [[ ${packages} -gt 0 ]]; then
echo "${packages} new packages 
			 (${msg1} and ${msg2})"
else 
echo " no new packages"
fi