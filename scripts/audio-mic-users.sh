#!/usr/bin/sh

on=$1
off=$2

# get names
# pactl list source-outputs | grep -Po "application.name = \K.*" | sed "s/^\([\"']\)\(.*\)\1\$/\2/g"
count=$(pactl list source-outputs | grep "" -c)

if [ $? -eq 0 ]; then
    echo "$on"
else
    echo "$off"
fi
