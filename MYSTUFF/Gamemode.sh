#!/usr/bin/env bash

# ==============================================================================
# Game.sh - Terminal Launcher for Intel HD 520 / i7-6600U
# ==============================================================================

# 1. Check if an argument was provided
if [ -z "$1" ]; then
    echo "❌ Usage:"
    echo "   For Steam:  bash Gamemode.sh <AppID> Properties > Update > ID"
    echo "   For .exe:   bash Gamemode.sh /path/to/game.exe"
    exit 1
fi

# ==============================================================================
# PERFORMANCE ENVIRONMENT VARIABLES
# ==============================================================================
export mesa_glthread=true
export vblank_mode=0
export MESA_NO_ERROR=1
export DXVK_ASYNC=1
export WINEESYNC=1
export WINEFSYNC=1
export DRI_PRIME=1

echo "🚀 Performance Mode Engaged!"

# ==============================================================================
# LAUNCH LOGIC
# ==============================================================================

# Check if the input is a number (Steam AppID)
if [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "🎮 Launching Steam AppID: $1..."
    # Launch via steam command
    exec gamemoderun steam steam://rungameid/"$1"

# Check if the input is a Windows .exe
elif [[ "$1" == *.exe ]]; then
    echo "🍷 Launching Windows Game: $1..."
    # Launch via wine (ensure wine is installed)
    exec gamemoderun wine "$@"

# Fallback for native Linux binaries or other commands
else
    echo "🕹️ Launching Custom Command: $@"
    exec gamemoderun "$@"
fi
