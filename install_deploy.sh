#!/bin/sh

# Get directory of "dotfiles"
INSTALL_DIR="$(pwd)"

# Install arch packages
sudo pacman -Syu --needed - < pkglist.txt

# Install yay if it does not already exist
if ! command -v yay &> /dev/null
then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
fi

cd "$INSTALL_DIR"

# Install AUR packages
yay -Sa --noconfirm --needed --needed - < aurlist.txt

# Deploy configs
./deploy.sh
