#!/bin/sh

sign=$1
vol=$2

if [ $1 != "-" ] && [ $1 != "+" ]; then
    vol=$1
    sign=""
fi

devices=$(playerctl -l)
kdeconnect=$(echo "$devices" | rg kdeconnect)
kde_error=$?
spotify=$(echo "$devices" | rg spotify)
spt_error=$?

function pm {
    if [ "$sign" == "" ]; then
        pulsemixer --max-volume 100 --set-volume $vol
    else
        pulsemixer --max-volume 100 --change-volume $sign$vol
    fi
}

if [ $kde_error == 0 ] && [ $(playerctl status "$kdeconnect") == "Playing" ]; then
    echo "kdeconnect"
    playerctl volume $(echo $vol | fish -c "math (playerctl volume) +$sign $vol / 100")
    exit
fi

if [ -x ~/.cargo/bin/pasv ]; then
    if ! ~/.cargo/bin/pasv $sign$vol%; then
        pm
    fi
else
    pm
fi
