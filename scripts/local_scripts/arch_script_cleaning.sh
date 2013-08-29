#!/bin/bash

# does an update
if [ -e "/var/lib/pacman/db.lck" ]; then
	sudo rm /var/lib/pacman/db.lck
fi

echo ":: Updating system..."
sudo pacman -Syu
echo " "
echo ":: Update complete..."
echo " "
sleep 2s
# function to check for and remove orphan packages
# this function looped by the while loop later
function orphanage {
echo ":: Checking if orphan packages exist on the system..."
ORPHANS=`pacman -Qqdt`
if [ -z "$ORPHANS" ]
then
    echo ":: System is clean, will exit..."
    sleep 3s
    exit
else
    echo -e ":: Orphans found on the system.\n$ORPHANS\n\n:: Removing..."
    sudo pacman -R --nosave $ORPHANS
fi
}
# end of orphan function
#
#
# infinite loop to find and remove orphan packages
# script exits when none found
while [ 1 ]
do
orphanage
done
# end of loop
#
#
# choose echo error message or zenity error message
echo ":: ** Update script did not exit normally!"
#zenity --warning --text="Update script did not exit normally"
sleep 8s
exit
