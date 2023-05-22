#!/bin/bash

function pref_spt {
    players=$(playerctl -l)
    player=$(echo "$players" | grep "spotify")

    if test $? -eq 0; then
        player=$(echo "$player" | head -n 1)
    else
        player=$(echo "$players" | head -n 1)
    fi

    echo $player
}

set -euo pipefail

case "${1:-}" in
  next)
    MEMBER=Next
    ;;

  previous)
    MEMBER=Previous
    ;;

  play)
    MEMBER=Play
    ;;

  pause)
    MEMBER=Pause
    ;;

  play-pause)
    MEMBER=PlayPause
    ;;

  *)
    echo "Usage: $0 next|previous|play|pause|play-pause"
    exit 1
    ;;

esac

exec dbus-send                                                           \
  --print-reply                                                          \
  --dest="org.mpris.MediaPlayer2.$(pref_spt)" \
  /org/mpris/MediaPlayer2                                                \
  "org.mpris.MediaPlayer2.Player.$MEMBER"
