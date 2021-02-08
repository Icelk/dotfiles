#!/bin/fish

set failed (echo (echo (systemctl list-units --failed)[2] | string split ' ')[1])

if test $failed -eq 1
    notify-send -a "Service Failed" -u critical "$failed service has failed. See systemctl status for more info."
else if test $failed -ne 0
   notify-send -a "Service Failed" -u critical "$failed services have failed. See systemctl status for more info."
end

