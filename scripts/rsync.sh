#!/usr/bin/bash

iter=0
declare -i iter
while ! ssh icelk@nas; do
    sleep 1
    iter+=1
    if [ $iter -gt 10 ]; then
        # Not connected to the home LAN
        exit 0
    fi
done

notify-send -a "Sync" "Starting..."

# -P: progress h: human a: archive v: verbose

rsync -ahP --del --delete-excluded /home icelk@nas:/mnt/main/laptop_erik/ --exclude-from="/home/icelk/Exclude-backup-home.txt"
echo "Done with /home"
rsync -ahP --del --delete-excluded /var icelk@nas:/mnt/main/laptop_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /var"
rsync -ahP --del --delete-excluded /usr/share icelk@nas:/mnt/main/laptop_erik/usr/ --exclude-from="/home/icelk/Exclude-backup-usr-share.txt"
echo "Done with /usr/share"
rsync -ahP --del --delete-excluded /usr/local icelk@nas:/mnt/main/laptop_erik/usr/
echo "Done with /usr/local"
rsync -ahP --del --delete-excluded /etc icelk@nas:/mnt/main/laptop_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
echo "Done with /etc"

mounted=$(mount -l)

if echo $mounted | grep -q "/boot "; then
    rsync -ahP --del --delete-excluded /boot icelk@nas:/mnt/main/laptop_erik/ --exclude-from="/home/icelk/Exclude-backup.txt"
    echo "Done with /boot"
else
    echo "/boot is not mounted, not syncing."
fi
if echo $mounted | grep -q "/win "; then
    rsync -ahP --del --delete-excluded /win icelk@nas:/mnt/main/laptop_erik/ --exclude-from="/home/icelk/Exclude-backup-win.txt"
    echo "Done with /win"
else
    echo "/win is not mounted, not syncing."
fi

notify-send -a "Sync" "Complete!"
