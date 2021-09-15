#!/usr/bin/sh
# Wait for an ip address
while ! ip address | grep "scope global dynamic">/dev/null; do sleep 1; done

# Do work!
