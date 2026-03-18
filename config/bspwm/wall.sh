#!/bin/bash

# Configuration
WALL_DIR="$HOME/.config/walls"

# Compact Dynamic Gallery - Flush Top
ROFI_STYLE='
window {
    width: 45%;
    location: north;
    anchor: north;
    y-offset: 0px;
    background-color: #0d0d0d;
    border: 0px 1px 1px 1px;
    border-color: #2a2a2a;
    border-radius: 0px 0px 8px 8px;
}
mainbox {
    children: [listview];
    padding: 6px;
    background-color: transparent;
}
listview {
    lines: 1;
    columns: 6;
    spacing: 10px;
    fixed-height: true;
    fixed-columns: false;
    scrollbar: false;
    background-color: transparent;
}
element {
    orientation: vertical;
    padding: 4px;
    border-radius: 4px;
    background-color: #151515;
}
element selected {
    background-color: #222222;
    border: 1px;
    border-color: #444444;
}
element-icon {
    size: 110px;
    horizontal-align: 0.5;
    background-color: transparent;
}
element-text {
    enabled: false;
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
