#!/bin/bash

#author: nomemory
#description: 
    #Cleans your *ubuntu

#variables 
    #deorphan link path
    declare deborphan="/usr/bin/deborphan"

    #deborphan package name
    declare deborphan_pname="deborphan"

    #temporary file
    declare tmp_file="temporary-file"

    #old configuration
    declare old_conf=$(dpkg -l | awk '/^rc/ {print $2}')

#sanity checks
    #test if user is root
    if [ `whoami` != "root" ] ; then
        echo "Please execute this script as root."
        exit -1
    fi
      
    #test if deborphan link path exists
    if [ ! -x $deborphan ] ; then
        echo "Deborphan not found. Installing deborphan."
        sudo apt-get install $deborphan_pname
    fi 

#functions
    #Aptitude.Clean
    function aptitude_clean {
        echo "--> Aptitude.Clean:"
        apt-get clean
    }
    #Aptitude.Autoclean
    function aptitude_autoclean {
        echo "--> Aptitude.Autoclean:"
        apt-get autoclean
    }
    #Aptitude.Autoremove
    function aptitude_autoremove {
        echo "--> Aptitude.Autoremove"
        apt-get autoremove
    }
    #Empty.Trash
    function empty_trash {
        echo "--> Empty.Trash:root"
        rm -rf /root/.local/share/Trash/*/**
        echo "--> Empty.Trash:allusers"
        rm -rf /home/*/.local/share/Trash/*/**        
                
    }
    #Old.Configuration
    function old_configuration {
        sudo apt-get purge $old_conf        
    }    
    #Cleaning using deborphan
    function clean_by_deborphan {
        echo "--> Clean.By.Deborphan"
          declare -i nr_pack=1
          while [ $nr_pack -ne 0 ] ; do 
                  $deborphan > $tmp_file
                  nr_pack=`cat $tmp_file | wc -l`
                  if [ $nr_pack -ne 0 ] ; then
                packages=""
                for line in `cat $tmp_file` ; do
                        packages="${packages} ${line}"
                done
                apt-get remove --purge --force-yes $packages
                  fi
        done
          rm $tmp_file
    }

#main script
    #If you wish to skip a "cleaning" step just comment
    #one of the following lines.
    aptitude_clean 
    aptitude_autoclean
    aptitude_autoremove    
    empty_trash
    old_configuration
    clean_by_deborphan

#exiting
exit 0
