#!/usr/bin/sh

PATH=~/.cargo/bin/:$PATH

if clipcatctl clear; then
  notify-send -a "clipcat" "Cleared clipboard history"
else
  notify-send -a "clipcat" "Failed to clear clipboard history" --urgency critical
fi
