#!/bin/sh
# click to start, click to stop

if /sbin/pidof conky | grep [0-9] > /dev/null
then
exec killall conky
else
sleep 10
conky &
conky -c ~/.conkyrc2 &
conky -c ~/.conkyrc3 &
conky -c ~/.conkyrc4 &
conky -c ~/.conkyrc5 &
exit
fi
