#!/usr/bin/sh

# Wait for internet connection
while ! ip address | grep "192.168.">/dev/null; do sleep 1; done

# The filename of your apps pid file.
PIDFILE="packages-upgradable-count.pid"

# Wait while it exists
while [[ -f "/tmp/run/$PIDFILE" ]]; do sleep 0.5; done
# Make sure the directory exists
mkdir -p "/tmp/run/"
# Create file
echo $$ > "/tmp/run/$PIDFILE"

OUTPUT=$(checkupdates 2>/dev/null)
while [[ $? -eq 1 ]]; do OUTPUT=$(checkupdates 2>/dev/null); done
if [[ -z $OUTPUT ]]; then
	echo 0
else
	echo "$OUTPUT" | grep "" -c
fi

# Delete it
rm -f "/tmp/run/$PIDFILE"
