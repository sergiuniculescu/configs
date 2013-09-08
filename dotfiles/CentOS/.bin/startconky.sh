#!/bin/sh
# click to start, click to stop

if /sbin/pidof conky | grep [0-9] > /dev/null
then
exec killall conky
else
sleep 10
conky
exit
fi
