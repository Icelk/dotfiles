#!/usr/bin/sh
# Wait for an ip address
while ! ip address | grep "192.168.">/dev/null; do sleep 1; done

# Do work!
