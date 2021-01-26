#!/usr/bin/sh
path=~/Pictures/screenshot.png

maim -su $path

if [ $? -eq 0 ]; then
    notify-send -a "Maim" "Took screenshot and saved it to '$path'!"
fi
