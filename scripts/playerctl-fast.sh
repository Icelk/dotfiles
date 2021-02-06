#!/bin/bash

function pref_spt {
    player=$(playerctl -l | grep "spotifyd")

    if test $? -eq 0; then
        set player $(echo $player | head -n 1)
    else
        set player $(playerctl -l | head -n 1)
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
