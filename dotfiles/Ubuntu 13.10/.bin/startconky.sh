#!/bin/sh
# click to start, click to stop

if /bin/pidof conky | grep [0-9] > /dev/null
then
exec killall conky
else
sleep 30
conky &
sleep 5
conky -c ~/.conkyrc_hdd &
sleep 5
conky -c ~/.conkyrc_cpu &
sleep 5
conky -c ~/.conkyrc_net &
exit
fi
