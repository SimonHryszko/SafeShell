#!/bin/bash

wallpaper_dir="$HOME/.wallpapers"
random_wallpaper=$(find "$wallpaper_dir" -type f -maxdepth 1 | shuf -n1)
feh --bg-scale "$random_wallpaper"