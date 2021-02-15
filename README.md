# About

These are all my dotfiles, which can be used to complete a setup with Nvidia graphics and an AMD processor (amd-ucode, can be easily swapped with intel-ucode).

> Right, almost forgot, I use **Arch Linux**

Removing the Nvidia packages, tweaking the Xorg config and changing the [ucode](https://wiki.archlinux.org/index.php/Microcode) should be enough to make it vendor agnostic.


# Major components

I use
- i3 gaps
- picom (ibhagwan's fork)
- polybar
- dunst
- rofi
- Brave
- VSCodium
- paru


# Installation

I have provided install scripts in the root of this directory. By default, they will not override anything and symlink to this directory.

If you want to install one version permanently (making it harder to upgrade), change the line `alias l="ln -s"` to `alias l="cp"`.

Other instructions will be shown when running the scripts.


# Contribution

Well, these are my personal dot-files. If you notice any issues, please open an issue, but I don't think I'll accept PRs if they're not well justified.

Anyway, you can use this under the MIT license.
