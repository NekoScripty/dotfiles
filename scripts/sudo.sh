#!/usr/bin/env bash

pacman -S sudo

# Exit immediately if a command exits with a non-zero status
set -e

# --- Color Definitions ---
GRAY='\033[1;30m'
WHITE='\033[1;37m'
RESET='\033[0m'

# --- ASCII Header ---
clear
echo -e "${GRAY}"
cat << "EOF"
 ┌────────────────────────────────────────────────────────┐
 │                                                        │
 │               USER PROVISIONING UTILITY                │
 │                                                        │
 └────────────────────────────────────────────────────────┘
EOF
echo -e "${RESET}"

# --- Privilege Check ---
if [[ "${EUID}" -ne 0 ]]; then
    echo -e "${GRAY}[${WHITE}!${GRAY}]${RESET} This script requires root privileges. Please run with sudo." >&2
    exit 1
fi

# --- User Input ---
echo -e "${GRAY}[${WHITE}+${GRAY}]${RESET} Enter new username:"
read -rp " > " username

if id "$username" &>/dev/null; then
    echo -e "${GRAY}[${WHITE}!${GRAY}]${RESET} Error: User '${username}' already exists."
    exit 1
fi

echo -e "\n${GRAY}[${WHITE}+${GRAY}]${RESET} Enter password for ${username}:"
read -rsp " > " password
echo

echo -e "\n${GRAY}[${WHITE}+${GRAY}]${RESET} Confirm password:"
read -rsp " > " password_confirm
echo

if [[ "$password" != "$password_confirm" ]]; then
    echo -e "${GRAY}[${WHITE}!${GRAY}]${RESET} Error: Passwords do not match. Aborting."
    exit 1
fi

# --- Execution ---
echo -e "\n${GRAY}[${WHITE}*${GRAY}]${RESET} Provisioning user account..."

# Create user, add to wheel group, set shell to bash
useradd -m -G wheel -s /bin/bash "$username"

# Set password securely
echo "$username:$password" | chpasswd
echo -e "${GRAY}[${WHITE}*${GRAY}]${RESET} User ${username} created and secured."

# Safely modify sudoers
echo -e "${GRAY}[${WHITE}*${GRAY}]${RESET} Configuring sudoers for %wheel group..."

TMP_SUDOERS=$(mktemp)
cp /etc/sudoers "$TMP_SUDOERS"

# Uncomment common wheel group patterns
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' "$TMP_SUDOERS"
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' "$TMP_SUDOERS"

# Validate syntax with visudo before applying to prevent lockouts
if visudo -c -f "$TMP_SUDOERS" &>/dev/null; then
    cp "$TMP_SUDOERS" /etc/sudoers
    echo -e "${GRAY}[${WHITE}*${GRAY}]${RESET} Sudoers configuration successfully updated."
else
    echo -e "${GRAY}[${WHITE}!${GRAY}]${RESET} Error: visudo validation failed. /etc/sudoers was NOT modified."
    rm -f "$TMP_SUDOERS"
    exit 1
fi

rm -f "$TMP_SUDOERS"

echo -e "\n${GRAY}[${WHITE}✓${GRAY}]${RESET} Setup complete. '${username}' is ready for use."
