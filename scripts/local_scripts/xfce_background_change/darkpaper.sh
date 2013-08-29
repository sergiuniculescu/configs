#!/bin/bash

d=~/images/wallpapers
delay=1800

if [[ $# != 1 ]]; then
	echo "Usage: $0 <percentage> (0 = dark, 100 = bright)"
	exit
fi

pct=$(echo $1 | awk '{printf "%d", (100*(2^($1/100)-1)/(2^1-1)+0.5)}')
pct_min=$(echo $(($1-10)) | awk '{printf "%d", (100*(2^($1/100)-1)/(2^1-1)+0.5)}')
pct_max=$(echo $(($1+20)) | awk '{printf "%d", (100*(2^($1/100)-1)/(2^1-1)+0.5)}')

wanted_brightness=$((pct*255/100))
min_brightness=$((pct_min*255/100))
max_brightness=$((pct_max*255/100))

cd $d
list=($(find . -maxdepth 1 -type f | shuf))
index=0

while true; do

	pic=${list[$index]}

	tmp=$(identify -verbose "$pic" | grep -A6 -E "Overall:|Gray:")
	mean=$(echo "$tmp" | grep "mean:" | awk '{print $2}' | cut -d'.' -f1)
	stddev=$(echo "$tmp" | grep "deviation:" | awk '{print $3}' | cut -d'.' -f1)
	pic_brightness=$((mean+stddev))

	if ((pic_brightness >= min_brightness && pic_brightness <= max_brightness)); then
		if ((pic_brightness >= wanted_brightness)); then
			delta_brightness=$((wanted_brightness - pic_brightness))
		else
			delta_brightness=0
		fi

		xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/brightness -s $delta_brightness
		xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s $d/$pic

		sleep $delay
	fi

	index=$((index+1))
	if (( index == ${#list[*]} )); then
		index=0
	fi
done