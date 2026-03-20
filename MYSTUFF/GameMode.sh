#!/usr/bin/env bash

# File to store your saved games
DB_FILE="$HOME/.game_list"

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

# ==============================================================================
# FUNCTIONS
# ==============================================================================

launch_game() {
    local TYPE=$1
    local TARGET=$2
    echo "🚀 Performance Mode Engaged!"

    if [ "$TYPE" == "STEAM" ]; then
        echo "🎮 Launching Steam AppID: $TARGET..."
        exec gamemoderun steam steam://rungameid/"$TARGET"
    elif [ "$TYPE" == "EXE" ]; then
        echo "🍷 Launching Windows Game: $TARGET..."
        exec gamemoderun wine "$TARGET"
    fi
}

save_game() {
    echo "$1|$2|$3" >> "$DB_FILE"
    echo "✅ Saved $1 to your list!"
}

# ==============================================================================
# MAIN MENU LOGIC
# ==============================================================================

echo "--- 🕹️ Linux Game Launcher ---"

# 1. Check if we have saved games and display them
if [ -f "$DB_FILE" ] && [ -s "$DB_FILE" ]; then
    echo "Select a saved game or add a new one:"

    # Read file into an array
    mapfile -t SAVED_GAMES < "$DB_FILE"

    # List saved games
    for i in "${!SAVED_GAMES[@]}"; do
        NAME=$(echo "${SAVED_GAMES[$i]}" | cut -d'|' -f1)
        echo "$((i+1)). $NAME"
    done
    echo "$(( ${#SAVED_GAMES[@]} + 1 )). [Add New Game]"

    read -p "Enter choice: " CHOICE

    # If user chose a saved game
    if [ "$CHOICE" -le "${#SAVED_GAMES[@]}" ]; then
        SELECTED="${SAVED_GAMES[$((CHOICE-1))]}"
        G_TYPE=$(echo "$SELECTED" | cut -d'|' -f2)
        G_TARGET=$(echo "$SELECTED" | cut -d'|' -f3)
        launch_game "$G_TYPE" "$G_TARGET"
    fi
fi

# 2. Setup New Game (if no file exists or user chose "Add New")
echo "--- 🆕 Add New Game ---"
echo "1. Steam Game (AppID)"
echo "2. Windows Game (.exe)"
read -p "Select Type: " TYPE_CHOICE

read -p "Enter a Title for this game: " G_TITLE

if [ "$TYPE_CHOICE" == "1" ]; then
    read -p "Enter Steam AppID: " G_ID
    save_game "$G_TITLE" "STEAM" "$G_ID"
    launch_game "STEAM" "$G_ID"
else
    read -p "Enter full path to .exe: " G_PATH
    # Clean up path if user dragged/dropped file into terminal
    G_PATH="${G_PATH%\'}"
    G_PATH="${G_PATH#\'}"
    save_game "$G_TITLE" "EXE" "$G_PATH"
    launch_game "EXE" "$G_PATH"
fi
