#!/usr/bin/sh

mode="2560x1440"
rate=165

xrandr --output DP-2 --mode $mode --rate $rate
xrandr --output DP-0 --mode $mode --rate $rate

xrandr --outout DP-2 --panning 2560x1440+0+0
xrandr --outout DP-0 --primary --panning 2560x1440+0+0
xrandr --outout DP-2 --pos 0x0
xrandr --outout DP-0 --right-of DP-2 --primary


sleep 5
systemctl --user restart polybar nitrogen
