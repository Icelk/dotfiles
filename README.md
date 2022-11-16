# About

These are all my dotfiles (lightly modified to fit my laptop), which can be used to complete a setup with Intel integrated graphics and an Intel processor (intel-ucode, can be easily swapped with amd-ucode).

> Right, almost forgot, I use **Arch Linux**. Sorry, `i use arch btw` 😎

Removing the Intel packages and changing the [µcode](https://wiki.archlinux.org/index.php/Microcode) should be enough to make it vendor agnostic.

Wayland should function regardless (see `config/hyprland.conf`)

> **Important**: Use Btrfs while installing Arch, not Ext4!

![screenshot of my rice](images/nvim-matrix-neofetch-kvarn.png)

## Branches

To use this setup on multiple systems, I've got multiple branches.

A branch named `macos` is available in this repo for other macOS users. It uses `homebrew` for managing packages.

One named `laptop` is for a more light-weight install for a laptop using Intel graphics, with Intel microcode. It looks the same but with smaller margins for smaller screens.

# Major components

I use

-   Btrfs
-   Hyprland
-   waybar
-   dunst
-   rofi (lbonn's fork for wayland support)
-   Kitty
-   NeoVim
-   Firefox
-   paru
-   spotifyd
-   iwctl (for connecting to WiFi)
-   Blueman (for connecting to Bluetooth)
-   Unbound

# Themes

I have theme support through [corpl](https://github.com/Icelk/iclu/tree/main/corpl).
These are a few combinations of GTK themes, cursor themes, and my themes I like to use.

[Flatery](https://store.kde.org/p/1332404/) (the black variant) is a icon theme I recommend that's not available in the AUR.

> These are all of course available after you've [installed](#installation).

> Adwaita is actually kinda nice!
> The dark variant is what I use.

You can change all these settings through the GUI program `lxappearance`.

## General recommendations

I can recommend the Arc Dark GTK theme, but think it's a bit difficult to read.
The Breeze Hacked cursors are a long-time favourite for me.

I prefer to use Roboto as the system font. Cantarell is also quite nice.
Isoevka Aile is also quite nice.

The theme collections below are formatted as follows:

-   My themes, accessible through `Meta (win) + Shift + t`
-   GTK theme (called `Widget` in `lxappearance`)
-   Mouse/cursor theme
-   Icon theme

## Clean

-   Light|dark (not "Dark split"!)
-   Adwaita dark
-   Breeze
-   Breeze dark

## Black

-   Dark
-   Adwaita dark
-   Sweet cursors
-   [Flatery](https://store.kde.org/p/1332404/)

## Sweet

-   Dark
-   Sweet dark
-   Sweet cursors
-   Candy icons (incorrectly named, part of the Sweet set)

## Balanced

-   Any
-   Arc dark
-   Sweet cursors
-   Candy icons

# Installation

I have provided install scripts in the root of this directory. By default they will symlink to this directory.

-   `install.sh` (run as your user)
-   `install-root.sh` (run as a superuser)
-   `install-plymouth-themes.sh` (run as your user, the script requests superuser privileges)
-   `install-rust-analyzer.sh` (run as your user, if you plan to edit Rust source code)
-   `install-packages.sh` (run as your user, the script requests superuser privileges)

**Note:** Also see [`other-installs`](other-installs.md) for the things I use which are not in the repos. I also recommend Firefox extensions here.

See [my drive layout](drive-layout.md) for info about backups.

> If you want to install one version permanently (making it harder to upgrade, as deleted files are left), change the line `alias l="ln -s"` to `alias l="cp"`.

Other instructions will be shown when running the scripts.

To install all the packages (with Paru), follow the installation instructions from [their GitHub](https://github.com/Morganamilo/paru). From there Paru will install all software.

> **Important:** To view the PKGBUILDs, you need to have [NvimPager](https://github.com/lucc/nvimpager) installed,
> as described in my [other installs](other-installs.md) document.
> It is set as the `$PAGER`, and not having it installed results in no output from Paru about PKGBUILDs.

# Contribution

Well, these are my personal dot-files. If you notice any issues, please open an issue, but I don't think I'll accept PRs if they're not well justified.

Anyway, you can use this under the MIT license.
