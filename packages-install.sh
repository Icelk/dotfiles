#!/bin/sh

packages=$( cat packages/installed.txt )

if [ "which paru" ]; then
    paru -S $packages
else
    yay -S $packages
fi

