#!/bin/bash

user=sergiu
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
cd /home/$user/
wget http://tv-maxe.googlecode.com/files/tv-maxe-0.08.tar.gz
tar -zxvf tv-maxe-0.08.tar.gz
mv tv-maxe-0.08 /home/$user/.tv-maxe
rm tv-maxe-0.08.tar.gz
echo -e '#!/bin/bash\ncd /home/sergiu/.tv-maxe && python tvmaxe.py &' | tee /home/$user/.tv-maxe/tvmaxe.sh
chown -R $user /home/$user/.tv-maxe
echo -e '[Desktop Entry]\nName=TV-Maxe\nGenericName=TV-Maxe\nComment=tv-internet\nExec=/home/sergiu/.tv-maxe/tvmaxe.sh\nIcon=/home/sergiu/.tv-maxe/tvmaxe.png\nTerminal=false\nType=Application\nCategories=AudioVideo;Player;' | sudo tee /usr/share/applications/tv-maxe.desktop
