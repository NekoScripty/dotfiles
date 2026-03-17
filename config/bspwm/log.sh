#!/usr/bin/env bash

# ==============================================================================
# Professional Rofi Power Menu (Full Black Theme - Borderless)
# ==============================================================================

set -u

# 1. Dependency Check
if ! command -v rofi >/dev/null 2>&1; then
    echo "Error: Rofi is not installed." >&2
    exit 1
fi

# 2. Path Variables
icon_dir="$HOME/.config/bspwm/logcons"

# Ensure icon directory exists
if [[ ! -d "$icon_dir" ]]; then
    echo "Error: Icon directory $icon_dir not found." >&2
    exit 1
fi

# Using .png icons
ic_logout="$icon_dir/logout.png"
ic_sleep="$icon_dir/sleep.png"
ic_reboot="$icon_dir/reboot.png"
ic_shutdown="$icon_dir/shutdown.png"

# 3. Menu Options
options="Logout\0icon\x1f$ic_logout\nSleep\0icon\x1f$ic_sleep\nReboot\0icon\x1f$ic_reboot\nShutdown\0icon\x1f$ic_shutdown"

# 4. Launch Rofi with Full Black Theme (No Outlines)
chosen=$(echo -e "$options" | rofi -dmenu \
    -i \
    -show-icons \
    -p "System" \
    -theme-str '
        * {
            background-color:    transparent;
        }
        window {
            location:           east;
            anchor:             east;
            x-offset:           -20px;
            width:              100px;
            background-color:   #000000;
            border:             0px;            /* Removed window border */
            border-radius:      12px;
            padding:            15px;
            children:           [ mainbox ];
        }
        mainbox {
            children:           [ listview ];
        }
        listview {
            layout:             vertical;
            lines:              4;
            spacing:            15px;
            fixed-height:       true;
        }
        element {
            padding:            10px;
            border-radius:      10px;
            background-color:   #000000;
            cursor:             pointer;
            children:           [ element-icon ];
        }
        element selected {
            background-color:   #444444;
            border:             0px;            /* Removed selection border */
        }
        element-icon {
            size:               48px;
            cursor:             inherit;
            horizontal-align:   0.5;
        }
        element-text {
            enabled:            false;
        }
        inputbar { enabled: false; }
    ')

# 5. Action Logic
case "$chosen" in
    "Logout")   loginctl terminate-session self ;;
    "Sleep")    systemctl suspend ;;
    "Reboot")   systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
    *)          exit 0 ;;
esac
