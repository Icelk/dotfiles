!> hide
<head>
    <title>TEST</title>
    [highlight]
</head>


# Disks

For the intents of this document, I have

-   1 TB SSD
-   4 TB HDD (archive)
-   A NAS with FreeNAS

# Backups

I'm using [btrbk](https://github.com/digint/btrbk) with systemd timers.

I snapshot my SSD one a day and keep them for 14 days.
I backup my SSD to my HDD.
I back up all my drives (including my win drive, HDD, SSD, drives for supporting data such as games)
to the NAS via `rsync` and use ZFS snapshots on the NAS.

See the [btrbk config file](root/btrbk.conf) for more details.

# SSD

For the SSD, I have a EFI partition (FAT32) to house the UEFI files.
After that, I have a 16GB swap partition.
Then, the rest is a Btrfs file system housing all my data.

## Subvolumes

I have two subvolumes in the root volume, `@` for `/` and `snapshots` for `/snapshots`.

See [this great article](https://blog.wohli.org/2017/06/19/Create-btrfs-subvolumes-retrospectively/) for instructions on how to move the root volume to a subvolume named `@`.

# HDD

This has one partition with Btrfs.
It houses all my archived files.

## Subvolumes

This has a subvolume at `.backups` for all the backups.

# Btrfs options

For all the Btrfs file systems, I use these mount options:

-   `compress-force=zstd` (compress all files, which reduces drive usage by more than 50%)
-   `noatime` (increase speed with the trade-off of no access timestamps)
-   `autodefrag` (defragment the file system on the fly)

# USB

I also have a USB (128GB) which serves several functions.
- Bootable ISOs
- Keyfile for laptop
- Generic file storage
- Encrypted storage for sensitive and personal files

I use [Ventory](https://ventoy.net) to make it bootable.
It allows me to drag ISO files to a exFAT file system to boot from them. The partition with the ISOs is 32GB in size.
This is set using the `-r` Ventoy command line option.

For the keyfile, I have a 1GB unformatted partiton with a 16KB keyfile at the start of it.

> This is my arguments for Linux on my laptop. `cryptdevice=UUID=<UUID of LUKS partition>:cryptroot:allow-discards root=/dev/mapper/cryptroot cryptkey=PARTUUID=<PARTUUID of partition on USB>:0:16384`

For file storage, I have a 64GB exFAT partition.

For the encrypted storage, I use the rest of the storage for a LUKS-encrypted partition with Btrfs.

# Fstab example

This is a example of a `fstab` for my configuration.

```ini
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>


##-----------------
# Main linux drive
##-----------------

# Main Btrfs file system
# /dev/nvme0n1p3 LABEL=os
UUID=<redacted>	/         	btrfs      	noatime,compress-force=zstd,autodefrag	0 0

# UEFI boot partition, using fat32.
# /dev/nvme0n1p1
UUID=<redacted>      	/boot     	vfat      	rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro	0 2

# Swap partion. 16GB
# /dev/nvme0n1p2
UUID=<redacted>	none      	swap      	defaults  	0 0

# Snapshot subvolume
# Same as main FS
UUID=<redacted>	/snapshots         	btrfs      	subvol=snapshots,noatime,compress-force=zstd,autodefrag	0 0


# Misc drive
# /dev/sdx1
UUID=<redacted>	/misc		btrfs		noatime,compress-force=zstd,autodefrag	0 0


# Archive
# /dev/sdx1 LABEL=archive
UUID=<redacted>	/archive  	btrfs      	noatime,compress-force=zstd,autodefrag 0 0


##--------
# Windows
##--------

# /dev/sdx2 LABEL=WinOS
UUID=<redacted>				/win		ntfs		rw,uid=1000,gid=988,dmask=007,fmask=117,noatime,big_writes,noauto,x-systemd.automount	0 0

# /dev/sdx1 LABEL=WinMisc
UUID=<redacted>				/win-misc 	ntfs      	rw,uid=1000,gid=988,dmask=007,fmask=117,noatime,big_writes,noauto,x-systemd.automount	0 0


##----
# NAS
##----

# Home nas share
nas:/mnt/main/<redacted>			/home/icelk/nfs/nas	nfs	defaults,_netdev,noauto,x-systemd.automount,user,noatime	0 0

# File sharing
nas:/mnt/main/file_share			/share			nfs	defaults,_netdev,noauto,x-systemd.automount,user,noatime	0 0


##---------
# External
##---------

# LUKS-encrypted partition when unlocked.
UUID=<redacted>      	/run/media/icelk/icePrivate  	btrfs	nofail,x-systemd.device-timeout=1ms,compress-force=zstd	0  0
```
