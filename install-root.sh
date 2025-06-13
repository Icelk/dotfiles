#!/bin/bash

cr=$(tput setaf 1)
cb=$(tput setaf 8)
cc=$(tput sgr0)

echo "${cr}Warning:${cc} You must be in the dotfile's root directory when running this script."
echo "${cr}Warning:${cc} This folder should be in a permanent place before running this script. Else critical system files will be broken links!"

echo "${cr}Warning:${cc} You must have root privileges to run this script."
echo
echo "This will not override any files. Use the flag '-f' to see all errors."
echo
echo "The owner of the doas config file will be changed to root."
echo
read -p "Press enter to continue or Ctrl+C to exit..."

shopt -s expand_aliases

echo "Add the -f flag to the following line in this script to override any present files. Useful if you move this directory."
alias l_cmd="ln -s"
wdr="$PWD/root"
bin="/usr/bin"

printfailed=$(if [[ "$1" == "-f" ]]; then echo yes; fi)

function l {
    from="$1"
    to="$2"
    if [[ "$from" == "-f" ]]; then
        from="-f $2"
        to="$3"
    fi
    mkdir -p $(dirname $to)
    result=$(l_cmd $from $to 2>&1)
    if [[ "$result" == *"File exists"* && -z $printfailed ]]; then
        # Do nothing
        :
    else
        echo "${cb}$result${cc}" >&2
    fi
}

# Suppress kernel info messages at boot.
l $wdr/kernel-info.conf /etc/sysctl.d/disable-kernel-info.conf

# Make the main RAM more used
l $wdr/swappiness.conf /etc/sysctl.d/less_swappy.conf

# Pacman config
l $wdr/pacman.conf /etc/

echo "Linking vi and vim to nvim, and sudo to doas."

l $bin/nvim $bin/vi
l $bin/nvim $bin/vim
l $bin/doas $bin/sudo

# rustup pacman hook
l $wdr/rustup.hook /etc/pacman.d/hooks/
echo "A rustup pacman hook has been installed. It will update Rust when the system updates. To remove it, unlink /etc/pacman.d/hooks/rustup.hook"

# Breeze icon theme hook
l $wdr/breeze.hook /etc/pacman.d/hooks/
l $wdr/nvidia.hook /etc/pacman.d/hooks/


# Enable auto-login
#mkdir /etc/systemd/system/getty@tty1.service.d
#ln -s $PWD/root/getty.conf /etc/systemd/system/getty@tty1.service.d/override.conf

#ln -s $PWD/root/fstab /etc/
#ln -sf $PWD/root/btrbk.conf /etc/btrbk/

echo
echo "An automatic login configuration file is included but not in this install script due to the username being needed. The line above (in this script) can be used to create a symlink."
echo "A xorg configuration file is included but not in this install script due to hardware-specific configuration. The line above (in this script) can be used to create a symlink."
echo "btrbk (backup utility) and fstab config files in included but commented out in this install script due to hardware-specific mount-points."


echo
read -p "The following will override certain system files. Press Ctrl+C to quit."
read -p "Please make sure this is what you want; it'll DELETE the target files!"
read -p "Also make sure your user is part of the 'wheel' group as the doas configuration file only allows users in that group."

# Networking: Avahi, Unbound, networkd, resolved
l -f $wdr/nsswitch.conf /etc/
unlink /etc/unbound/unbound.conf
cp $wdr/unbound.conf /etc/unbound/
mkdir /etc/systemd/network
ln -f $wdr/network/* /etc/systemd/network/
ln -f $wdr/resolved.conf /etc/systemd/
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Redis (used for DNS cache)
unlink /etc/redis/redis.conf
cp $wdr/redis.conf /etc/redis/

# Reduced pam failure timeout
l -f $wdr/pam-system-auth /etc/pam.d/system-auth

# Hosts
ln -f $wdr/hosts /etc/
echo "The hosts file contains 'icelk' as the name of this computer. You might want to change that if you want another name to link to localhost."

# chrony
cp $wdr/chrony.conf /etc/

# makepkg
l -f $wdr/makepkg.conf /etc/

# doas
cp $wdr/doas.conf /etc/
chown root:root /etc/doas.conf

# journalctl max size
l -f $wdr/journald.conf /etc/systemd/

# pacman
l -f $wdr/pacman.conf /etc/

l $wdr/archlinux-keyring-wkd-sync-fix.service /etc/systemd/system/archlinux-keyring-wkd-sync.service.d/override.conf
l $wdr/powertop.service /etc/systemd/system/

l -f $wdr/icelk-layout /usr/share/X11/xkb/symbols/icelk

# reflector
# ln -sf $wdr/reflector.conf /etc/xdg/reflector/
echo "A reflector configuration file was included, but it contains location-specific options and isn't installed. See this script for the command."

echo
read -p "Services will now be started. The rest of the installation is successful. Press Ctrl+C to quit."
read -p "Are you sure you want to enable dhcpcd, periodic TRIM, reflector (Pacman mirrorlist updater), CUPS (printing), and Unbound & Redis (DNS)? These will not eat much processor time. Start avahi-daemon to discover printers on the network."
systemctl enable --now fstrim.timer reflector.timer cups redis unbound dbus-broker chrony tuned powertop systemd-networkd systemd-resolved
