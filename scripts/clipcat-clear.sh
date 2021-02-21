#!/usr/bin/sh

if clipcatctl clear; then
  notify-send -a "clipcat" "Cleared clipboard history"
else
  notify-send -a "clipcat" "Failed to clear clipboard history" --urgency critical
fi
