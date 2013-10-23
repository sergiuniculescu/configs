#!/bin/bash

move_and_fullscreen(){
  NAME='XBMC Media Center'

  while [ -z "`wmctrl -l | grep \"$NAME\"`" ]
  do
      sleep 1
  done

  wmctrl -r "$NAME" -e '0,0,-1,-1,-1'
  wmctrl -r "$NAME" -b toggle,fullscreen
}

move_and_fullscreen &
__GL_SYNC_TO_VBLANK=1 __GL_SYNC_DISPLAY_DEVICE=DFP-0 SDL_VIDEO_ALLOW_SCREENSAVER=0 exec xbmc
