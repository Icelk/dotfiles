#!/bin/sh

sign=$1
vol=$2

if [ $1 != "-" ] && [ $1 != "+" ]; then
    vol=$1
    sign=""
fi

function pm {
    if [ "$sign" == "" ]; then
        pulsemixer --max-volume 100 --set-volume $vol
    else
        pulsemixer --max-volume 100 --change-volume $sign$vol
    fi
}

if [ -x ~/.cargo/bin/pasv ]; then
    if ! ~/.cargo/bin/pasv $sign$vol%; then
        pm
    fi
else
    pm
fi
