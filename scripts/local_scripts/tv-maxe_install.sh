#!/bin/bash

sudo zypper install python-imaging
wget http://sopcast-player.googlecode.com/files/sp-auth-3.2.6.tar.gz
tar -zxvf sp-auth-3.2.6.tar.gz
rm sp-auth-3.2.6.tar.gz
cd sp-auth/
sudo cp sp-sc-auth /usr/bin/
cd ..
rm -rf sp-auth/
wget http://www.sopcast.com/download/libstdcpp5.tgz
tar -zxvf libstdcpp5.tgz
rm libstdcpp5.tgz
cd libstdcpp5
sudo cp libstdc++.so.5.0.1 /usr/lib/
rm -rf libstdcpp5
cd /usr/lib/
sudo ln -s libstdc++.so.5.0.1 libstdc++.so.5
cd ~
wget http://tv-maxe.googlecode.com/files/tv-maxe-0.08.tar.gz
tar -zxvf tv-maxe-0.08.tar.gz
rm tv-maxe-0.08.tar.gz
mv tv-maxe-0.08 ~/.tv-maxe
cd ~/.tv-maxe
python tvmaxe.py
echo -e '#!/bin/bash\ncd /home/$USER/.tv-maxe && python tvmaxe.py &' | tee ~/.tv-maxe/tvmaxe.sh
echo -e '[Desktop Entry]\nName=TV-Maxe\nGenericName=TV-Maxe\nComment=tv-internet\nExec=/home/$USER/.tv-maxe/tvmaxe.sh\nIcon=/home/$USER/.tv-maxe/tvmaxe.png\nTerminal=false\nType=Application\nCategories=AudioVideo;Player;' | sudo tee /usr/share/applications/tv-maxe.desktop
