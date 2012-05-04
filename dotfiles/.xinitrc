#
#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

mpd
xrdb -merge ~/.Xresources 
setxkbmap ro
exec ck-launch-session dbus-launch awesome 


#VBoxClient-all &
