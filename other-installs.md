Not all programs I use exist in the AUR or Arch package repos. Here is a
collection of the rest and how to manually install them.

ToDo: Add this all to the install script!

# Adding users and groups

```bash
# useradd -m -G wheel,seat,cups,docker,plugdev,libvirt -s /bin/fish icelk
# passwd icelk
```

Add missing groups using `groupadd <group name>`

# Copying /etc/doas.conf

You have to install `opendoas` and copy the doas.conf file from this repo to
`/etc/doas.conf` to use doas. I also like to force-uninstall sudo
(`pacman -Rsndd sudo`) and symlink doas instead (`ln -sf /bin/doas /bin/sudo`).

# Pasv

Smooth volume changer. Download & install both crates from [this repo](https://github.com/Icelk/pulseaudio-smooth-volume-change).

# systemd-boot

Run `# bootctl install` to install the boot manager. Then you have to add
entries to `/boot/loader/entries/`. These are not provided in this repo since
they are device specific.

# Cargo

Install the package `rustup` and run `rustup toolchain install stable`

Then you should be available to install the programs (while in the appropriate
directories) via `cargo install --path .`

All binaries in <https://github.com/Icelk/iclu>

Spotify-player
`cargo install spotify_player -F notify,image,lyric-finder,pulseaudio-backend,streaming,media-control --no-default-features`

[My fork of clipcat](https://github.com/Icelk/clipcat)

<https://github.com/okaneco/kmeans-colors>

# NVimPager

I built [NVimPager](https://github.com/lucc/nvimpager) without the man pages
(the dependencies were countless...) by commenting out the lines in the
`makefile` in a local clone. It is therefore not present in `installed.txt`.

That _should_ be all... (PR me if I'm wrong)

# Firefox

Some Firefox settings are overridden by `config/firefox-user.js`

I use these extensions:

-   Bitwarden (free password manager with sync and support to self-host
    passwords!)
-   Multi-Account Containers (a must-have with Firefox. Lets you have multiple
    "containers" of cookies)
-   Forget Me Not (great extension to clear unused `localstorage` and cookies)
-   Tridactyl (installed using `pacman`. Navigation with the keyboard)

# Ripgrep & recent files in neovim using Ctrl+p

Proper sorting isn't merged into ripgrep yet, so I run my patch. You'll have to
compile ripgrep using the path in the comment at the link below.
<https://github.com/BurntSushi/ripgrep/issues/2243#issuecomment-1622559768>

# Brave

-   Set `about:flags#ozone-platform-hint` to `Auto`
