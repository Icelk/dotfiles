#!/usr/bin/sh

all=$(pacman -Q | grep "" -c)
echo "? / $all"

upgradable=$(. ~/scripts/packages-upgradable-count.sh)
echo "$upgradable / $all"
