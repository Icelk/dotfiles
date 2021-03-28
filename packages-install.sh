#!/bin/sh

echo "You have to have homebrew installed."

packages=$( cat packages/installed.txt )

brew install $packages
