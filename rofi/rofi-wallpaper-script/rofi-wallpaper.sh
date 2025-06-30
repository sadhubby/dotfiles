#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR=~/Pictures/wallpapers

# Check if directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send "Wallpaper directory not found: $WALLPAPER_DIR"
  exit 1
fi

# Run rofi to select a wallpaper
wallpaper=$(ls "$WALLPAPER_DIR" | rofi -dmenu -i -p "Select wallpaper:" -font "JetBrains Mono Nerd Font 24" -config ~/.config/rofi/config-wallpaper.rasi)

# If wallpaper selected, set it with swww
if [ -n "$wallpaper" ]; then
  swww img "$WALLPAPER_DIR/$wallpaper" --transition-fps="120"
  notify-send "Wallpaper changed to: $wallpaper"
fi
