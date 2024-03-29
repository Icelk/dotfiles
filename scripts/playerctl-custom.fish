#!/bin/fish

set play_pause_volume_smooth_duration 200
set play_pause_volume_smooth_duration_s (math $play_pause_volume_smooth_duration / 1000)

# Clone of `playerctl`. Sends the second argument (e.g. `PlayPause` `Pause` etc.) to the first argument's media player.
function pctl
    dbus-send --type=method_call --dest="org.mpris.MediaPlayer2.$argv[1]" /org/mpris/MediaPlayer2 "org.mpris.MediaPlayer2.Player.$argv[2]"
end

# Super-fast compared to (playerctl status)
# Gets the property of the media player defined by the first argument filtered by the second argument.
# To get the playback status of `spotify`, use `pctl_get "spotify" "PlaybackStatus"`
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

# Cache the initial status of spotify
set spt_status ""
if pactl list clients | grep -i spotify
    set spt_status "Playing"
else
    set spt_status "Paused"
end

echo $spt_status

# Gets a media player (returned by `playerctl -l`). This prefers spotify above all other.
function pref_spt
    set player (playerctl -l | grep "spotify")
    
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
    # If it's spotify
    if string match -q $player "spotifyd" || string match -q $player spotify_player
        # and playing, pause it.
        if string match -q $spt_status "Playing"
            if test -f ~/.cargo/bin/pasv
                set -f volume (~/.cargo/bin/pasv -g)
                ~/.cargo/bin/pasv -d $play_pause_volume_smooth_duration 0
                sleep $play_pause_volume_smooth_duration_s
            end

            pctl $player "Pause"

            # wait for pause
            sleep 0.4
            if test -f ~/.cargo/bin/pasv
                ~/.cargo/bin/pasv -d 0 $volume
            end
            exit 0
        end
    else
        # Else, if the status of the player is `Playing`, pause it and exit
        if string match -q (pctl_get $player "PlaybackStatus") "Playing"
            if test -f ~/.cargo/bin/pasv
                set -f volume (~/.cargo/bin/pasv -g)
                ~/.cargo/bin/pasv -d $play_pause_volume_smooth_duration 0
                sleep $play_pause_volume_smooth_duration_s
            end

            pctl $player "Pause"

            # wait for pause
            sleep 0.2
            if test -f ~/.cargo/bin/pasv
                ~/.cargo/bin/pasv -d 0 $volume
            end
            exit 0
        end
    end
end

if test -f ~/.cargo/bin/pasv
    set -f volume (~/.cargo/bin/pasv -g)
    ~/.cargo/bin/pasv -d 0 0
end

# it seems like pipewire (and maybe pulseaudio) doesn't apply the volume for a bit
# 
# it shows up as changed in polybar and pulsemixer, but the audio output contains a short loud sound
# Therefore, we sleep to let the volume change take effect
sleep 0.2
# If there was nothing to pause (the we would've `exit`ed), play from the preferred editor.
pctl (pref_spt) "Play"

sleep 0.1

# wait for play
if test -f ~/.cargo/bin/pasv
    ~/.cargo/bin/pasv -d $play_pause_volume_smooth_duration $volume
end
