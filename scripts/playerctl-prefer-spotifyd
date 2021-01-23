#!/usr/bin/fish

set player (playerctl -l | grep "spotifyd")

if test $status -eq 0
	set player (echo $player | head -n 1)
else
	set player (playerctl -l | head -n 1)
end

echo $player
