#!/usr/bin/sh

cjar="/tmp/captive-cookies.cookies"
path="portal.php"

alias c="curl -c $cjar -b $cjar -iso /dev/null"

ip=$(curl -Is http://icelk.dev | rg "location: " | rg -o "([0-9]+\.?)+")

if [ $? -ne 0 ]; then
    notify-send "Redirect not IP (we're already connected?)"
    exit 0
fi

notify-send "Connecting to captive portal $ip".

# Get cookies
c http://$ip/$path

notify-send "Got cookies."

# Submit
c http://$ip/$path -d "connect="

notify-send "Connected!"
