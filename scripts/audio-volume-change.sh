#!/bin/sh

sign=$1
vol=$2

if [ $1 != "-" ] && [ $1 != "+" ]; then
    vol=$1
    sign=""
fi

function pm {
    if [ "$sign" == "" ]; then
        pulsemixer --max-volume 100 --set-volume ${sign}$vol
    else
        pulsemixer --max-volume 100 --change-volume ${sign}$vol
    fi
}

if [ -f ~/.cargo/bin/pasv ]; then
    pasv_vol=$(echo "scale=2 ; $vol / 100" | bc)
    if ! ~/.cargo/bin/pasv ${sign}$pasv_vol; then
        pm
    fi
else
    pm
fi
