#!/usr/bin/env bash

# ==============================================================================
# Game.sh - Max Performance Wrapper for Intel HD 520 / i7-6600U
# ==============================================================================

# 1. Input Validation
# Ensure a game executable or launch command is provided
if [ -z "$1" ]; then
    echo "❌ Error: No game specified."
    echo "Usage: ./Game.sh <path_to_game_executable> [additional_arguments...]"
    exit 1
fi

echo "🚀 Initializing Max Performance Mode..."

# ==============================================================================
# ENVIRONMENT VARIABLES & TWEAKS
# ==============================================================================

# --- OpenGL & Mesa Tweaks (Intel iGPU Specific) ---
# Enables OpenGL multithreading. Helps your i7-6600U process graphics calls faster.
export mesa_glthread=true

# Disables VSync in OpenGL. This forces the GPU to render as fast as possible,
# unlocking your max FPS (note: this may cause minor screen tearing).
export vblank_mode=0

# Disables Mesa's error checking overhead for a tiny performance bump.
export MESA_NO_ERROR=1

# --- DXVK & Wine/Proton Tweaks (For Windows games on Linux) ---
# Enables asynchronous shader compilation to drastically reduce stuttering in-game.
export DXVK_ASYNC=1
export DXVK_STATE_CACHE=1

# Enables Esync and Fsync to reduce CPU overhead and improve multithreading performance.
export WINEESYNC=1
export WINEFSYNC=1

# Prioritize the discrete GPU (redundant here, but good practice for ensuring
# the system doesn't fall back to software rendering).
export DRI_PRIME=1

# ==============================================================================
# EXECUTION
# ==============================================================================

echo "🎮 Launching via gamemoderun..."

# gamemoderun automatically changes the CPU governor to 'performance',
# changes I/O priority, and optimizes the GPU power state.
# "$@" passes the game and all its arguments perfectly intact.

exec gamemoderun "$@"
