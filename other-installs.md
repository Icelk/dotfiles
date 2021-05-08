Not all programs I use exist in the AUR or Arch package repos.
Here is a collection of the rest and how to manually install them.

ToDo: Add this all the the install script!

# Cargo
Install the package `rustup` and run `rustup toolchain install stable`

Then you should be available to install the programs (while in the appropriate directories) via `cargo install --path .`

All binaries in <https://github.com/Icelk/iclu>

My version of spotifyd ([until it's merged with the master branch](https://github.com/Spotifyd/spotifyd/pull/750)) <https://github.com/Icelk/spotifyd> with `cargo install --path . --features "pulseaudio_backend, dbus_mpris"`

<https://github.com/okaneco/kmeans-colors>


# Other

## VSCode extensions
You know how to install them...

- Code Spell Checker
- Git Graph
- GitLens
- rust-analyzer
- Vim
- Not in <https://open-vsx.org>
    > My extension <https://github.com/Icelk/auto-start-terminal>
    >
    > Can be built with vsce (available in npm (e.g. `npm install -g vsce`)) and
    > installed using the three-dots-menu in the top right of the extensions page under `Install from VSIX...`

## NVimPager

I built [NVimPager](https://github.com/lucc/nvimpager) without the man pages (the dependecies were countless...) by commenting out the lines in
the `makefile` in a local clone. It is therefore not present in `installed.txt`.

That *should* be all... (PR me if I'm wrong)
