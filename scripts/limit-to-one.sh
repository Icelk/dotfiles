#!/usr/bin/sh

# The filename of your apps pid file.
PIDFILE="app.pid"

# Wait while it exists
while [[ -f "/tmp/run/$PIDFILE" ]]; do sleep 0.5; done
# Make sure the directory exists
mkdir -p "/tmp/run/"
# Create file
echo $$ > "/tmp/run/$PIDFILE"

## Your command!
sleep 2

# Delete it
rm "/tmp/run/$PIDFILE"
