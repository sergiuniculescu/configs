#!/bin/bash

if [[ $# != 1 ]]; then
	echo "Usage: $0 <percentage> (0 = dark, 100 = bright)"
	exit
fi

min_color=3900
max_color=5550
min_light=0.65
max_light=1.0

# Update current value displayed in the menu
#sed -i "s/Current: [^%]*%/Current: $1%/" "$XDG_DATA_HOME/redshift.sh/redshift-display.desktop"

# Apply exponential function to percentage to make the progression more linear
# to the eye
#pct=$(echo "scale=2;100*(e($1/100)-1)/(e(1)-1)"|bc -l)
pct=$(echo $1 | awk '{printf "%d", (100*(2^($1/100)-1)/(2^1-1)+0.5)}')

color=$(echo "$min_color+($max_color-$min_color)*$pct/100" | bc)
light=$(echo "scale=2;$min_light+($max_light-$min_light)*$pct/100" | bc)

pkill '^redshift$'
nohup redshift -l 45.0:5.0 -t $color:$color -b $light:$light -r &>/dev/null &

# Update background picture
pkill 'darkpaper.sh'
lum=$(($1 * 85 / 100 + 5))
nohup ./darkpaper.sh $lum &>/dev/null &