#!/bin/sh

if xmodmap -pke | grep -q "keycode *67 *= *bracket"; then
    xmodmap ~/.Xmodmap-alternative
    notify-send -a "Xmodmap switcher" "Now using alternative layout."
else
    xmodmap ~/.Xmodmap
    notify-send -a "Xmodmap switcher" "Now using default layout."
fi
