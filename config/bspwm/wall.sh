#!/bin/bash

# Configuration
WALL_DIR="$HOME/.config/walls"

# Formal Black and Grey Theme - 4x4 Grid
ROFI_STYLE='
window {
    width: 60%;
    height: 70%;
    anchor: center;
    location: center;
    background-color: #0d0d0d;
    border: 1px;
    border-color: #2a2a2a;
    border-radius: 12px;
}
mainbox {
    children: [listview];
    padding: 30px;
    background-color: transparent;
}
listview {
    columns: 4;
    lines: 4;
    spacing: 20px;
    fixed-height: true;
    fixed-columns: true;
    scrollbar: false;
    background-color: transparent;
}
element {
    orientation: vertical;
    padding: 15px;
    border-radius: 8px;
    background-color: #151515;
    text-color: #999999;
}
element selected {
    background-color: #222222;
    border: 1px;
    border-color: #444444;
    text-color: #ffffff;
}
element-icon {
    size: 110px;
    horizontal-align: 0.5;
    background-color: transparent;
}
element-text {
    horizontal-align: 0.5;
    font: "JetBrainsMono Nerd Font 9";
    margin: 10px 0px 0px 0px;
    background-color: transparent;
}
'

# Generate list and launch Rofi
choice=$(ls "$WALL_DIR" | while read -r file; do
    echo -en "$file\0icon\x1f$WALL_DIR/$file\n"
done | rofi -dmenu -i -theme-str "$ROFI_STYLE")

# Apply selection
if [ -n "$choice" ]; then
    feh --bg-fill "$WALL_DIR/$choice"
    notify-send "System" "Wallpaper Updated: $choice"
fi
