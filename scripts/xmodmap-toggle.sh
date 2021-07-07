#!/bin/sh

if xmodmap -pke | grep -q "keycode *67 *= *bracket"; then
    xmodmap ~/.Xmodmap-alternative
else
    xmodmap ~/.Xmodmap
fi
