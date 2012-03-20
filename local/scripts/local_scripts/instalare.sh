#!/bin/bash

#Sergiu Niculescu

#medibuntu
sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update

#ubuntu-tweak
sudo apt-add-repository ppa:tualatrix/ppa

#temele bisigi
sudo apt-add-repository ppa:bisigi/ppa

#tema orta
sudo apt-add-repository ppa:nikount/orta-desktop 

#faenza temă iconițe
sudo apt-add-repository ppa:tiheum/equinox

#dockbarx
sudo add-apt-repository ppa:dockbar-main/ppa

#vlc
sudo add-apt-repository ppa:n-muench/vlc

#pidgin
sudo add-apt-repository ppa:pidgin-developers/ppa

#actualizați, pentru siguranță
sudo apt-get update

#instalare programe
#începând cu Maverick, aptitude a fost scos din instalarea implicită
sudo apt-get install -y aptitude

#nautilus elementary
sudo add-apt-repository ppa:am-monkeyd/nautilus-elementary-ppa
sudo apt-get update && sudo apt-get dist-upgrade
nautilus -q

#gloobus-preview (space to view)
sudo add-apt-repository ppa:gloobus-dev/gloobus-preview
sudo apt-get update && sudo apt-get install gloobus-preview && sudo apt-get upgrade

#wine si winetricks
sudo add-apt-repository ppa:ubuntu-wine/ppa && sudo apt-get update && sudo apt-get install ttf-mscorefonts-installer && sudo apt-get install wine1.3
sudo winetricks fontfix fontsmooth-rgb gdiplus tahoma gecko vcrun2005 vcrun2008 ie6

#programe dezvoltare
sudo aptitude install build-essential deborphan alien checkinstall automake libgtk2.0-dev 

#programe utilitare
sudo aptitude install ubuntu-tweak p7zip-full gparted chkrootkit acpi mesa-utils htop ntp obexftp obexpushd skype sun-java6-jre startupmanager

#programe internet
sudo aptitude install radiotray furiusisomount firestarter skype wireshark 

#teme, iconițe, grafică
sudo aptitude install bisigi-themes orta-theme faenza-icon-theme dockbarx dockbarx-themes-extra
sudo aptitude install compiz compizconfig-settings-manager compiz-fusion-plugins-main compiz-gnome compiz-fusion-plugins-extra

sudo echo "deb http://ppa.launchpad.net/cairo-dock-team/ppa/ubuntu $(lsb_release -sc) main ## Cairo-Dock-PPA" | sudo tee -a /etc/apt/sources.list 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E80D6BF5 
sudo apt-get update 
sudo apt-get install cairo-dock cairo-dock-plug-ins

sudo add-apt-repository ppa:conky-companions/ppa
sudo apt-get update
sudo apt-get install conky-all
sudo apt-get install python-statgrab ttf-droid curl
sudo apt-get install conkyemail

#multimedia, jocuri
sudo aptitude install libdvdcss2 ubuntu-restricted-extras

#audio, video
sudo aptitude install moc vlc libvlc-dev soundconverter audacity
