#!/usr/bin/sh

# Wait for internet connection
while ! ip address | grep "state UP">/dev/null; do sleep 0.25; done

# The filename of your apps pid file.
# PIDFILE="packages-upgradable-count.pid"

# Wait while it exists
# while [[ -f "/tmp/run/$PIDFILE" ]]; do sleep 0.5; done
# Make sure the directory exists
# mkdir -p "/tmp/run/"
# Create file
# echo $$ > "/tmp/run/$PIDFILE"

OUTPUT="ERROR"
while [[ "$OUTPUT" == *"ERROR"* ]]; do sleep 0.2; OUTPUT=$(timeout 5 checkupdates 2>&1); done
if [[ -z $OUTPUT ]]; then
	echo 0
else
	echo "$OUTPUT" | grep "" -c
fi

# Delete it
# rm -f "/tmp/run/$PIDFILE"
