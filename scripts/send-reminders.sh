#!/bin/fish

set init_time 120
set interval_time 10

set application "Reminder"

set file ~/Reminder.txt
set content (cat $file)

sleep $init_time

for line in $content
    if test -n "$line"
        notify-send -a $application $line
        sleep $interval_time
    end
end

