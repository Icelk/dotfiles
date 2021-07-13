# About

These are all my macOS dotfiles, which can be used to make transitioning to macOS easier when using my Linux dotfiles.

> Right, almost forgot, I use **Arch Linux**

## macOS

Lately, I've had to start using macOS. A branch named `macos` is available in this repo for other macOS users. It uses `homebrew` for managing packages.

# Major components

I use
- Homebrew
- Kitty
- NeoVim
- Brave

# Installation

I have provided install scripts in the root of this directory. By default, they will not override anything, but symlink to this directory.

If you want to install one version permanently (making it harder to upgrade, as deleted files are left), change the line `alias l="ln -s"` to `alias l="cp"`.

Other instructions will be shown when running the scripts.

To install the Homebrew, run this in a Fish shell.
```shell
$ brew install (cat packages/installed-macos.txt)
```

# Contribution

Well, these are my personal dot-files. If you notice any issues, please open an issue, but I don't think I'll accept PRs if they're not well justified.

Anyway, you can use this under the MIT license.
