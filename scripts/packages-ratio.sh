#!/usr/bin/sh

upgradable=$(. ~/scripts/packages-upgradable-count.sh)
all=$(pacman -Q | grep "" -c)
echo "$upgradable / $all"
