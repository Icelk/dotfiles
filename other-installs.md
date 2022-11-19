Not all programs I use exist in the AUR or Arch package repos.
Here is a collection of the rest and how to manually install them.

ToDo: Add this all to the install script!

# Cargo
Install the package `rustup` and run `rustup toolchain install stable`

Then you should be available to install the programs (while in the appropriate directories) via `cargo install --path .`

All binaries in <https://github.com/Icelk/iclu>

My version of spotifyd ([until it's merged with the master branch](https://github.com/Spotifyd/spotifyd/pull/750)) <https://github.com/Icelk/spotifyd> with `cargo install --path . --features "pulseaudio_backend, dbus_mpris"`

[My fork of clipcat](https://github.com/Icelk/clipcat)

<https://github.com/okaneco/kmeans-colors>

# NVimPager

I built [NVimPager](https://github.com/lucc/nvimpager) without the man pages (the dependencies were countless...) by commenting out the lines in
the `makefile` in a local clone. It is therefore not present in `installed.txt`.

That *should* be all... (PR me if I'm wrong)

# Firefox

Some Firefox settings are overridden by `config/firefox-user.js`

I use these extensions:
- Bitwarden (free password manager with sync and support to self-host passwords!)
- Multi-Account Containers (a must-have with Firefox. Lets you have multiple "containers" of cookies)
- Forget Me Not (great extension to clear unused `localstorage` and cookies)
- Tridactyl (installed using `pacman`. Navigation with the keyboard)

# Brave

- Set `about:flags#ozone-platform-hint` to `Auto`
