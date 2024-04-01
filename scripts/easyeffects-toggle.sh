#!/bin/sh

if [ "$(easyeffects -b 3)" == 1 ]; then
    easyeffects -b 2
    notify-send -a "Easy Effects" -i easyeffects "Enabled audio effects"
else
    easyeffects -b 1
    notify-send -a "Easy Effects" -i easyeffects "Disabled audio effects"
fi
