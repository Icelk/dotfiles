#!/usr/bin/fish

set cjar "/tmp/captive-cookies.cookies"

alias c="curl -c $cjar -b $cjar -iso /dev/null"
alias ns="notify-send -a 'Captive portal'"

# Echo to remove whitespaces
set portal (curl -Is http://icelk.dev | grep "location: " | awk '{print $2}' | string trim)

# Scan for IP
set ip (echo $portal | rg -o "([0-9]+\.?)+")

if test $status -ne 0
    ns "Redirect not IP (we're already connected?)"
    exit 0
end

ns "Connecting to captive portal '$portal'".

# Get cookies
c $portal

ns "Got cookies."

# Submit
c $portal -d "connect="

ns "Connected!"
