#!/usr/bin/sh
path=~/Pictures/screenshot-"$(date "+%+4Y-%m-%d-%T")".png

maim $path

if [ $? -eq 0 ]; then
    notify-send -a "Maim" "Took screenshot of whole screen and saved it to '$path'!"
fi
