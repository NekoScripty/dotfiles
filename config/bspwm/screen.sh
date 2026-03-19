#!/bin/bash

# --- 1. ASCII Header & Auto-Detect ---
clear
echo "############################################################"
echo "#                                                          #"
echo "#    ____   ____ ____  _____ _____ _   _  ____  ____       #"
echo "#   / ___| / ___|  _ \| ____| ____| \ | |/ ___|/ ___|      #"
echo "#   \___ \| |   | |_) |  _| |  _| |  \| | \___ \___ \      #"
echo "#    ___) | |___|  _ <| |___| |___| |\  |  ___) |__) |     #"
echo "#   |____/ \____|_| \_\_____|_____|_| \_| |____/____/      #"
echo "#                                                          #"
echo "#                 DISPLAY CONFIGURATION                    #"
echo "############################################################"

# Auto-detect monitor
MON=$(xrandr | grep " connected" | awk '{print $1}' | head -n 1)

if [ -z "$MON" ]; then
    echo -e "\n[!] Error: No monitor detected."
    exit 1
fi

echo -e "\nTarget Device: [ $MON ]"
echo "------------------------------------------------------------"

# --- 2. Input Logic with Strict Validation ---

# 1. Resolution
while true; do
    read -p ">> Resolution (e.g. 1920x1080): " RES
    if [[ "$RES" =~ ^[0-9]+x[0-9]+$ ]]; then
        break
    fi
    echo "   Error: Please put correct value (Format: 1920x1080)."
done

# 2. Refresh Rate
while true; do
    read -p ">> Refresh Rate (e.g. 60): " RATE
    if [[ "$RATE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        break
    fi
    echo "   Error: Please put correct value (Numbers only)."
done

# 3. Rotation
while true; do
    read -p ">> Rotation (normal/left/right/inverted): " ROT
    if [[ "$ROT" =~ ^(normal|left|right|inverted)$ ]]; then
        break
    fi
    echo "   Error: Please put correct value (normal, left, right, inverted)."
done

# 4. Scale
while true; do
    read -p ">> Scale (e.g. 1.0): " SCALE
    if [[ "$SCALE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        break
    fi
    echo "   Error: Please put correct value (e.g. 1.0 or 1.2)."
done

# 5. Stretched (New Option)
while true; do
    read -p ">> Stretched Aspect Ratio? (y/n): " STRETCH_INPUT
    if [[ "$STRETCH_INPUT" =~ ^(y|n)$ ]]; then
        if [ "$STRETCH_INPUT" == "y" ]; then
            STRETCH_VAL="Full"
        else
            STRETCH_VAL="Full aspect"
        fi
        break
    fi
    echo "   Error: Please enter 'y' for Yes (Stretched) or 'n' for No (Maintain Aspect)."
done

# --- 3. Execution ---
echo -e "\n------------------------------------------------------------"
echo "Status: Applying changes..."

# First, apply the stretching property
xrandr --output "$MON" --set "scaling mode" "$STRETCH_VAL" 2>/dev/null

# Apply the rest of the configuration
if xrandr --output "$MON" --mode "$RES" --rate "$RATE" --rotate "$ROT" --scale "${SCALE}x${SCALE}" 2>/dev/null; then
    echo "Status: [ SUCCESS ] Display updated (Stretching: $STRETCH_VAL)."
else
    echo "Status: [ FAILED ] xrandr rejected these values."
fi
echo "############################################################"
