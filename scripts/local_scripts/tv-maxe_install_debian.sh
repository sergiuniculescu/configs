#!/bin/bash

###############################################################################
###################### Copyleft by Sergiu Niculescu ###########################
###############################################################################
############ Inspired by kernel-ck compiling script from:  ####################
### http://viajemotu.wordpress.com/2012/08/13/kernel-ck-for-ubuntu-precise/ ###
###############################################################################
############################ !!! ENJOY !!! ####################################
###############################################################################


function header()
{
    clear
    echo -e "\033[1m-----------------------------\033[7m INSTALLING TV-MAXE on openSUSE \033[0m\033[1m----------------------------\033[0m"
    echo -e "\033[1m  tv-maxe source:\033[0m     https://code.google.com/p/tv-maxe/"
    echo -e "\033[1m  sp-auth source:\033[0m     http://sopcast-player.googlecode.com"
    echo -e "\033[1m  libstdcpp5 source:\033[0m  http://www.sopcast.com/download/linux.html"
    echo
	echo -e "\033[1m---------------------------------------------------------------------------------------\033[0m"
    echo
}

_exec()
{
    status=$?
    if [ $status != 0 ]; then
        exit $status
    fi
    echo "[+] $@"
    $@
}

function _rotate ()
{
    pid=$1
    animation_state=1

    while [ "`ps -p $pid -o comm=`" ]; do
        # rotating star
        echo -e -n "\b\b\b"
        case $animation_state in
            1)
                echo -n "["
                echo -n -e "\033[1m|\033[0m"
                echo -n "]"
                animation_state=2
                ;;
            2)
                echo -n "["
                echo -n -e "\033[1m/\033[0m"
                echo -n "]"
                animation_state=3
                ;;
            3)
                echo -n "["
                echo -n -e "\033[1m-\033[0m"
                echo -n "]"
                animation_state=4
                ;;
            4)
                echo -n "["
                echo -n -e "\033[1m"
                echo -n "\\"
                echo -n -e "\033[0m"
                echo -n "]"
                animation_state=1
                ;;
        esac
        sleep 1
    done
}

function test_root()
{
    mkdir -p "tmp_path"

    if [ ! "$LOGNAME" == "root" ]; then
        echo "[+] detecting user $LOGNAME (non-root)"
        echo "[+] checking if sudo is available ... "
        sudotest=`type sudo &>/dev/null ; echo $?`

        if [ "$sudotest" == 0 ]; then
            sudo -K
            if [ -e "tmp_path/sudo.test" ]; then
                rm -f "tmp_path/sudo.test"
            fi
            while [ -z "$sudopwd" ]; do
                echo -n "   - enter sudo-password: "
                stty -echo
                read sudopwd
                stty echo

                # password check
		mkdir -p "tmp_path"
                echo "$sudopwd" | sudo -S touch "tmp_path/sudo.test" |& tee /tmp/sudo.output
                InSudoers=$(grep -i "sudoers" /tmp/sudo.output)
                if [ -n "$InSudoers" ]; then
                    rm /tmp/sudo.output
                    exit
                fi

                if [ ! -e "tmp_path/sudo.test" ]; then
                    sudopwd=""
                fi
            done

            SUDO="/usr/bin/sudo -S"

            rm -f "tmp_path/sudo.test"
            echo
        else
            echo "You're not root and sudo isn't available. Please run this script as root!"
            exit
        fi
    fi
}

function cleanup ()
{
    stty echo
    echo
    echo "[+] deleting files at tmp_path ... "
    rm -rf ../tmp_path
    if [ -z $1 ]; then
        exit
    fi
}

function _waitfor ()
{
    sleep 1s

    running=$(pidof $1); running=$?
    if [ "$running" == "1" ]; then
        echo -e "\b\b\b\b\b done"
    else
        _rotate $(pidof $1)
        echo -e "\b\b\b\b\b done"
    fi
}

header
test_root

echo -e "\033[1m--------------------------------\033[7m Fixing dependencies \033[0m\033[1m--------------------------------\033[0m"

echo "$sudopwd" | _exec $SUDO apt-get update
echo "$sudopwd" | _exec $SUDO apt-get install python-imaging python-glade2 ffmpeg
_exec echo
####################################################################################################

echo -e "\033[1m--------------------------------\033[7m Downloading archives \033[0m\033[1m-------------------------------\033[0m"
echo "[+] downloading sp-auth ...    "
_exec cd tmp_path
_exec wget --no-check-certificate -N wget http://sopcast-player.googlecode.com/files/sp-auth-3.2.6.tar.gz

echo "[+] downloading libstdcpp5 ...    "
_exec wget --no-check-certificate -N wget http://www.sopcast.com/download/libstdcpp5.tgz

echo "[+] downloading tv-maxe ...    "
_exec wget --no-check-certificate -N wget http://tv-maxe.googlecode.com/files/tv-maxe-0.09.tar.gz

echo -e "\033[1m-----------------------------\033[7m Applying dependencies \033[0m\033[1m------------------------------\033[0m"
echo "[+] uncomprensing the sp-auth to tmp_path/ ...    "
_exec tar -xzvf sp-auth-3.2.6.tar.gz & _waitfor tar
echo "[+] uncomprensing the libstdcpp5 to tmp_path/ ...    "
_exec tar -xzvf libstdcpp5.tgz & _waitfor tar
echo "[+] uncomprensing the tv-maxe to tmp_path/ ...    "
_exec tar -xzvf tv-maxe-0.09.tar.gz & _waitfor tar
_exec echo 

echo "[+] applying dependencies ...    "
echo "$sudopwd" | _exec $SUDO cp sp-auth/sp-sc-auth /usr/bin/
echo "$sudopwd" | _exec $SUDO cp usr/lib/libstdc++.so.5.0.1 /usr/lib/
echo "$sudopwd" | _exec $SUDO ln -s /usr/lib/libstdc++.so.5.0.1 /usr/lib/libstdc++.so.5
echo "$sudopwd" | _exec $SUDO mv tv-maxe-0.09 /opt/tv-maxe
_exec echo 

echo -e '#!/bin/bash\ncd /opt/tv-maxe && python tvmaxe.py &' | tee /opt/tv-maxe/tvmaxe.sh
echo "$sudopwd" | _exec $SUDO chmod +x /opt/tv-maxe/tvmaxe.sh
_exec echo 

echo -e "\033[1m-----------------------------\033[7m Creating a shortcut in the Debian menu \033[0m\033[1m------------------------------\033[0m"
echo -e '[Desktop Entry]\nName=TV-Maxe\nGenericName=TV-Maxe\nComment=tv-internet\nExec=/opt/tv-maxe/tvmaxe.sh\nIcon=/opt/tv-maxe/tvmaxe.png\nTerminal=false\nType=Application\nCategories=AudioVideo;Player;' | sudo tee /usr/share/applications/tv-maxe.desktop

echo "[+] have fun with TV-MAXE on Debian ^_^!"

cleanup 1
