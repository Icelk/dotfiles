#!/bin/sh

set -euo pipefail

if [ -f /tmp/locked ] ; then exit ; fi

touch /tmp/locked
(
    until fprintd-verify | grep "verify-match"; do
        echo "Failed to verify fingerprint at $(date)" | systemd-cat
    done
    echo "Unlocked at $(date)" | systemd-cat
    pkill -USR1 hyprlock
) &
hyprlock

rm /tmp/locked
kill $(jobs -p)
pkill fprintd-verify
