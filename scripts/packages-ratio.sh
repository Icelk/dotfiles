#!/usr/bin/sh

all=$(pacman -Q | grep "" -c)
echo "$all"

upgradable=$(. ~/scripts/packages-upgradable-count.sh)
if [ $upgradable == 0 ]; then
    echo "$all"
else
    echo "$upgradable / $all"
fi
