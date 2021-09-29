#!/usr/bin/sh
path=~/Pictures/screenshot-"$(date "+%+4Y-%m-%d-%T")".png

maim -su $path

if [ $? -eq 0 ]; then
    notify-send -a "Maim" "Took screenshot and saved it to '$path'!"
fi
