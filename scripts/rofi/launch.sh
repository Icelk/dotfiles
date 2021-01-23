#!/bin/bash

menu="$1"

if [ "$menu" = "music" ]; then
    rofi -modi 'Music:~/scripts/rofi/music.sh' -show Music -theme music-launcher
elif [ "$menu" = "appmenu" ]; then
    rofi -show drun -theme clean
elif [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/scripts/rofi/powermenu.sh' -show Powermenu -theme powermenu
fi
