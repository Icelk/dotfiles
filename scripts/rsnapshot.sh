#!/usr/bin/sh

PIDFILE=".rsnapshot.pid"

while [[ -f "$HOME/$PIDFILE" ]]; do sleep 0.5; done

notify-send -a "rsnapshot" "Running $1"

## Your command!
rsnapshot $1

notify-send -a "rsnapshot" "Finished $1"
