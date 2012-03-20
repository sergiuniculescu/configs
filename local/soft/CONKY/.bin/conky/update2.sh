#!/bin/sh
# save resources by querying the db once, reuse the output
output=`pacman -Qu`
numofup=`echo "$output" | grep Targets | sed 's/Targets (\([0-9]*\).*/\1/' `
if [ -n "$numofup" ]; then
    sizeofup=`echo "$output" | grep "Total Installed Size" \
                             | cut -d ':' -f 2             \
                             | sed 's/^ *//'` 

    # pacman -Qu wont tell us how much to dl, skipping this one
    #dlsize=`echo "$output" | grep "Total Download Size" \
    #                       | cut -d ':' -f 2          \
    #                       | sed 's/^ *//'` 
    echo "\${color}\${alignr}" "$numofup new Packets"

    #echo -e "\${alignr}\${color}($dlsize / $sizeofup)" 
    #echo -e "\t \${color0}" "dl/inst" "\${alignr}\${color}$dlsize / $sizeofup" 
    echo -e "\t \${color}Install Size:" "\${alignr}\${color}$sizeofup" 
else
    echo "\${color}\${alignr}" "System up-to-date"
fi