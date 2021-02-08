#!/bin/fish

set application "Reminder"

set file ~/Reminder.txt
set content (cat $file)

for line in $content
    if test -n "$line"
        notify-send -a $application $line
    end
end

