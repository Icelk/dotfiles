#!/bin/sh

python -c "print(str($(cat /sys/class/power_supply/BAT0/charge_now) / $(cat /sys/class/power_supply/BAT0/charge_full) * 100) + '%')"
