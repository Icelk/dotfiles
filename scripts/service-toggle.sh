#!/usr/bin/sh

unit=$1
notify=$2

message="";
active=$(systemctl --user is-active $unit)

if [ $? -ne 0 ]; then
    # Not active
    if [ $(systemctl --user restart $unit) ]; then
        message="Failed to start unit $unit"
    else
        message="Started unit $unit"
    fi
else
    # Active
    if [ $(systemctl --user stop $unit) ]; then
        message="Failed to stop unit $unit"
    else
        message="Stopped unit $unit"
    fi
fi

    echo $active
echo $message

if [ $notify ]; then
    notify-send -a "Services" "$message"
fi