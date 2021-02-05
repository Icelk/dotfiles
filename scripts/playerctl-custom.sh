#!/bin/fish

set get_prefer_spt ~/scripts/playerctl-prefer-spotifyd.sh

function pctl
    dbus-send --print-reply --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.$argv[2]"
end
# Super-fast compared to playerctl status
function pctl_get
    echo (echo (dbus-send --print-reply --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.freedesktop.DBus.Properties.Get" string:"org.mpris.MediaPlayer2.Player" string:"$argv[2]") | string split '"')[2]
end

for player in (playerctl -l)
    if string match (pctl_get $player "PlaybackStatus") 'Playing'
        pctl $player "Pause"
        exit 0
    end
end

pctl ($get_prefer_spt) "Play"
