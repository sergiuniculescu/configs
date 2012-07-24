#!/usr/bin/env bash
#creat de @calvarr http://linuxfans.ro/viewtopic.php?f=34&t=314
echo http://www.filmeonline.org v.0.2
wget -qO - http://www.filmeonline.org/|grep bookmark|sed -e :a -e 's/<[^>]*>/ /g;/</N;//ba;s/\&#8211//g;s/^[ \t]*//'|nl
echo selectati numarul filmului dorit sau cautati altul '"s"'
echo pentru a parasi tastati '"q"'
read cautare
if test "$cautare" = "s" ; then echo Ce film cautam?
read film
wget -qO - http://www.filmeonline.org/search/$film/|grep bookmark|sed -e :a -e 's/<[^>]*>/ /g;/</N;//ba;s/\&#8111//g;s/^[ \t]*//'|nl
echo alegeti numarul filmului
read numar
adresa=`wget -qO - http://www.filmeonline.org/search/$film/|grep bookmark|sed -n "${numar}p"|sed 's/ /_/g;s/"/ /g'|awk '{print $4}'`
elif test "$cautare" = "q" ; then exit; 
else 
adresa=`wget -qO - http://www.filmeonline.org/|grep bookmark|sed -n "${cautare}p"|sed 's/ /_/g;s/"/ /g'|awk '{print $4}'`
fi
upload=`wget -qO - $adresa|grep VK|sed 's/ /_/g;s/"/ /g;s/?/ /g;s/\;/\&/g;s/\#038//g'|sed -n '1p'|awk '{print $3}'`
wget -qO - "http://vk.com/video_ext.php?$upload"|sed -n '/video_host/,/video_vtag/ p'|sed "s/ /_/g;s/'/ /g"|awk '{print $2}' > /tmp/surse
host=`cat /tmp/surse|sed -n '1p'`
uid=`cat /tmp/surse|sed -n '2p'`
vtag=`cat /tmp/surse|sed -n '3p'`
rezolutie=.240.mp4
stream="$host"u$uid/video/$vtag
echo 'Pentru a reda tastati "r", pentru a descarca tastati "d"'
echo 'pentru a parasi tastati "q"'
read valoare

consola=`echo $DISPLAY'a'`
if test "$consola" = "a" ; then
echo "Introduceti marimea ferestrei de redare (ex. 360), apoi si coordonatele acesteia (ex. 10:10) "
read marime
read coordonate
else
marime=360
coordonate=10:20
fi
if test "$valoare" = "r" ; then mplayer -cache 1000 -hardframedrop -cache-min 20 -msglevel cache=-1 -prefer-ipv4 -msgcolor -nolirc -ao alsa -vo xv,fbdev2, -xy $marime -zoom -geometry $coordonate $stream.240.mp4
elif test "$valoare" = "d" ; then axel $stream.480.mp4||axel $stream.360.mp4||axel $stream.240.mp4
#elif test "$valoare" = "d" ; then wget -O $stream
elif test "$valoare" = "q" ; then rm /tmp/surse ; exit;
fi