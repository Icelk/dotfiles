#!/bin/fish

function pctl
    dbus-send --type=method_call --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.$argv[2]"
end

# Super-fast compared to (playerctl status)
function pctl_get
    set response (dbus-send --reply-timeout=500 --print-reply --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.freedesktop.DBus.Properties.Get" string:"org.mpris.MediaPlayer2.Player" string:"$argv[2]")
    if test $status -ne 0
        echo "Stopped"
    else
        echo (echo $response | string split '"')[2]
    end
end

set spt_status (pctl_get "spotifyd" "PlaybackStatus")

function pref_spt
    set player (playerctl -l | grep "spotifyd")
    
    if test $status -eq 0 && ! string match -q $spt_status "Stopped"
        set player (echo $player | head -n 1)
    else
        set player (playerctl -l | head -n 1)
    end

    echo $player
end

for player in (playerctl -l)
    if string match -q $player "spotifyd"
        if string match -q $spt_status "Playing"
            pctl $player "Pause"
            exit 0
        end
    else
        if string match -q (pctl_get $player "PlaybackStatus") "Playing"
            pctl $player "Pause"
            exit 0
        end
    end
end

pctl (pref_spt) "Play"
