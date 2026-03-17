#!/bin/bash

# PipeWire installation script for Arch Linux

echo "Installing PipeWire and components..."
sudo pacman -S --noconfirm pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber

echo "Disabling PulseAudio..."
systemctl --user stop pulseaudio.service pulseaudio.socket 2>/dev/null
systemctl --user disable pulseaudio.service pulseaudio.socket 2>/dev/null

echo "Enabling PipeWire services..."
systemctl --user enable pipewire.service wireplumber.service pipewire-pulse.service
systemctl --user start pipewire.service wireplumber.service pipewire-pulse.service

echo "Installing useful tools..."
sudo pacman -S --noconfirm pavucontrol helvum qpwgraph pamixer

echo "Verifying installation..."
sleep 2
systemctl --user status pipewire --no-pager
pactl info | grep "Server Name"

echo "Setting default volume to 40%..."
wpctl set-volume @DEFAULT_AUDIO_SINK@ 40%
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 40%

echo "PipeWire installation complete!"
echo "You may need to reboot or restart your applications."
