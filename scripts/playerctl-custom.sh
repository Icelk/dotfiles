#!/bin/fish

function pctl
    dbus-send --print-reply --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.$argv[2]"
end

# Super-fast compared to (playerctl status)
function pctl_get
    set response (dbus-send --reply-timeout=25 --print-reply --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.freedesktop.DBus.Properties.Get" string:"org.mpris.MediaPlayer2.Player" string:"$argv[2]")
    if test $status -ne 0
        echo "Stopped"
    else
        echo (echo $response | string split '"')[2]
    end
end

function pref_spt
    set player (playerctl -l | grep "spotifyd")
    
    if test $status -eq 0 && ! string match -q (pctl_get spotifyd "PlaybackStatus") 'Stopped'
        set player (echo $player | head -n 1)
    else
        set player (playerctl -l | head -n 1)
    end

    echo $player
end

for player in (playerctl -l)
    set response (pctl_get $player "PlaybackStatus")
    if string match (pctl_get $player "PlaybackStatus") 'Playing'
        pctl $player "Pause"
        exit 0
    end
end

pctl (pref_spt) "Play"
