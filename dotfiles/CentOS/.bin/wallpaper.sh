#!/bin/bash
while true
do
# Script to randomly set Background from files in a directory

# Directory Containing Pictures
DIR="/home/sergiu/Dropbox/Linux/National_Geographic"

# Command to Select a random jpg file from directory
# Delete the *.jpg to select any file but it may return a folder
PIC=$(ls $DIR/*.jpg | shuf -n1)

# Command to set Background Image
gconftool-2 -t string -s /desktop/gnome/background/picture_filename "$PIC"

sleep 600
done
