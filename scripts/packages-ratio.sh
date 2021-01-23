#!/usr/bin/sh

upgradable=$(. ~/scripts/packages-upgradable-count.sh)
all=$(. ~/scripts/packages-count.sh)
echo "$upgradable / $all"
