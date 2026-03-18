#!/usr/bin/env bash

# Define colors for professional output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

## --- PRE-FLIGHT CHECKS ---
if [[ $EUID -eq 0 ]]; then
   log_error "Do not run this script as root. It will ask for sudo when needed."
fi

## --- STAGE 1: CORE REPOSITORIES ---
log_info "Updating system and installing core packages..."
CORE_PKGS="bspwm sxhkd polybar rofi dmenu procps-ng brightnessctl pamixer playerctl xorg-xkill xorg-xrandr xsel xclip xterm konsole dolphin chromium htop networkmanager feh scrot xorg-server xorg-xinit xf86-input-libinput xorg-xprop xorg-xwininfo bleachbit materia-gtk-theme lightdm lightdm-gtk-greeter ttf-font-awesome adobe-source-han-sans-jp-fonts ttf-iosevka-nerd gwenview git nano curl wget less rust net-tools htop krita libdbusmenu-gtk3 libdbusmenu-qt5"

if sudo pacman -Syu --needed --noconfirm $CORE_PKGS; then
    log_success "Core packages installed."
else
    log_error "Failed to install core packages via pacman."
fi

## --- STAGE 2: AUR HELPER & PACKAGES ---
if command -v yay &> /dev/null; then
    log_info "Installing AUR packages..."
    if yay -S --needed --noconfirm whitesur-icon-theme vibrant-cli neofetch cava; then
        log_success "AUR packages installed."
    else
        log_info "AUR installation failed, but continuing with core setup..."
    fi
else
    log_info "Yay not found. Skipping AUR packages. Please install 'whitesur-icon-theme' manually later."
fi

## --- STAGE 3: CONFIGURATION DEPLOYMENT ---
log_info "Deploying configuration files..."

# Ensure we are in the correct directory (Dotfiles)
if [[ -d "config" ]]; then
    mkdir -p ~/.config
    cp -r config/* ~/.config/
    cp fetch.Xresources ~/.Xresources
    cp fetch.bashrc ~/.bashrc
    log_success "Dotfiles copied to ~/.config."
else
    log_error "Directory 'config' not found. Ensure you are running this from your Dotfiles folder."
fi

## --- STAGE 4: PERMISSIONS & EXECUTABLES ---
log_info "Setting executable permissions for scripts..."

# List of critical scripts from your setup
SCRIPTS=(
    "$HOME/.config/bspwm/bspwmrc"
    "$HOME/.config/bspwm/log.sh"
    "$HOME/.config/bspwm/screen.sh"
    "$HOME/.config/bspwm/wall.sh"
    "$HOME/.config/sxhkd/sxhkdrc"
)

for script in "${SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        chmod +x "$script"
        log_info "Set +x on $script"
    else
        log_info "Warning: $script not found, skipping chmod."
    fi
done

## --- STAGE 5: SYSTEM ASSETS & LIGHTDM ---
log_info "Configuring LightDM and system backgrounds..."

sudo mkdir -p /usr/share/backgrounds

if [[ -f "wallpaper.jpg" ]] && [[ -f "pfp.jpg" ]]; then
    sudo cp wallpaper.jpg /usr/share/backgrounds/
    sudo cp pfp.jpg /usr/share/backgrounds/

    # Writing the Greeter config using a here-doc
    sudo tee /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null <<EOF
[greeter]
background = /usr/share/backgrounds/wallpaper.jpg
theme-name = Materia-dark
icon-theme-name = Adwaita
font-name = Sans 11
position = 50%,center 50%,center
indicators = ~host;~spacer;~clock;~spacer;~session;~language;~a11y;~power
clock-format = %A, %d %B %Y, %H:%M
user-background = false
default-user-image = /usr/share/backgrounds/pfp.jpg
hide-user-image = false
show-indicators = true
screensaver-timeout = 60
EOF
    log_success "LightDM configured."
else
    log_info "System images (wallpaper.jpg/pfp.jpg) missing. Skipping LightDM visual config."
fi

log_success "Installation Complete! Please reboot or restart your X session."
