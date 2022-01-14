#!/usr/bin/sh

xprop -id $(xdotool selectwindow) | grep CLASS | awk '{print $4}'
