sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf

# Steam

sudo pacman -S chromium git steam gamemode mangohud wine-staging lib32-gamemode lutris

# I7 6600 Gfxdrivers

sudo pacman -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver lib32-libva-intel-driver

#yay Dependencies
yay -S proton-ge-custom

