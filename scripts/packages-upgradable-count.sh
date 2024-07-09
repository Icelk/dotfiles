#!/usr/bin/sh

# Wait for internet connection
while ! ip address | grep "state UP">/dev/null; do sleep 2; done

# The filename of your apps pid file.
# PIDFILE="packages-upgradable-count.pid"

# Wait while it exists
# while [[ -f "/tmp/run/$PIDFILE" ]]; do sleep 0.5; done
# Make sure the directory exists
# mkdir -p "/tmp/run/"
# Create file
# echo $$ > "/tmp/run/$PIDFILE"

OUTPUT=$(timeout 20 checkupdates 2>&1)
if [[ "$OUTPUT" == *"ERROR"* ]]; then echo "ERR"; exit 1; fi
if [[ -z $OUTPUT ]]; then
	echo 0
else
	echo "$OUTPUT" | grep "" -c
fi

# Delete it
# rm -f "/tmp/run/$PIDFILE"
