#!/bin/bash

# Check if rofi is installed
if ! [ -x "$(command -v rofi)" ]; then
    logger -t "$0" "Error: rofi is not installed."
    echo "Error: rofi is not installed." >&2
    exit 1
fi

# list of options (files in $HOME/src)
options=$(find "$HOME"/src -maxdepth 1 -type f -executable -printf "%f\n")
logger -t "$0" "OPTIONS: $options"

# prompt user to select an option
selected=$(echo "$options" | rofi -dmenu -i -p "Select an option:")
logger -t "$0" "SELECTED: $selected"

# execute the selected option
if [ -n "$selected" ]; then
    "$HOME/src/$selected"
fi