#!/usr/bin/fish

# Get services
# The \ is escaped twice, therefore we have to write \\\\ to get it to accept a \
set services (systemctl --user list-units --state=active --type=service --no-pager --no-legend | rg -o " *[a-z0-9\\-\\.@_:\\\\]*\\.service *" | string trim | string sub -e -8)

# Get count
set count (count $services)

# If count >= 40, clamp it!
if test $count -ge 40
    set count 40
end

# Get input from user, with $count lines
set selected (printf "%s\n" $services | rofi -dmenu -l $count -i -p "Restart service")

if test $status -eq 0
    # Restart service
    systemctl --user restart $selected
end
