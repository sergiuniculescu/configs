#!/bin/sh

while true;
do
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri file://"$(find ~/Pictures/National_Geographic -type f | shuf -n1)";
sleep 600;
done
