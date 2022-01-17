#!/usr/bin/fish

set cjar "/tmp/captive-cookies.cookies"

alias c="curl -c $cjar -b $cjar -iso /dev/null"

# Echo to remove whitespaces
set portal (curl -Is http://icelk.dev | grep "location: " | awk '{print $2}' | string trim)

# Scan for IP
set ip (echo $portal | rg -o "([0-9]+\.?)+")

if test $status -ne 0
    notify-send "Redirect not IP (we're already connected?)"
    exit 0
end

notify-send "Connecting to captive portal '$portal'".

# Get cookies
c $portal

notify-send "Got cookies."

# Submit
c $portal -d "connect="

notify-send "Connected!"
