#!/bin/fish

# Clone of `playerctl`. Sends the second argument (e.g. `PlayPause` `Pause` etc.) to the first argument's media player.
function pctl
    dbus-send --type=method_call --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.$argv[2]"
end

# Super-fast compared to (playerctl status)
# Gets the property of the media player defined by the first argument filtered by the second argument.
# To get the playback status of `spotifyd`, use `pctl_get "spotifyd" "PlaybackStatus"`
function pctl_get
    # Get the data from DBUS
    set response (dbus-send --reply-timeout=1000 --print-reply --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.freedesktop.DBus.Properties.Get" string:"org.mpris.MediaPlayer2.Player" string:"$argv[2]")
    # If the response was a error
    if test $status -ne 0
        echo "Stopped"
    else
        # Else get the actual response
        echo (echo $response | string split '"')[2]
    end
end

# Cache the initial status of spotifyd
set spt_status ""
if pactl list clients | grep -i spotifyd
    set spt_status "Playing"
else
    set spt_status "Paused"
end

# Gets a media player (returned by `playerctl -l`). This prefers spotifyd above all other.
function pref_spt
    set player (playerctl -l | grep "spotifyd")
    
    if test $status -eq 0
        set player (echo $player | head -n 1)
    else
        set player (playerctl -l | head -n 1)
    end

    echo $player
end

# Loop on each media player
# This checks for any media player playing, and if they are, pause and exit.
for player in (playerctl -l)
    # If it's spotifyd
    if string match -q $player "spotifyd"
        # and playing, pause it.
        if string match -q $spt_status "Playing"
            pctl $player "Pause"
            exit 0
        end
    else
        # Else, if the status of the player is `Playing`, pause it and exit
        if string match -q (pctl_get $player "PlaybackStatus") "Playing"
            pctl $player "Pause"
            exit 0
        end
    end
end

# If there was nothing to pause (the we would've `exit`ed), play from the preferred editor.
pctl (pref_spt) "Play"
