#!/bin/sh

# Get directory of "dotfiles"
INSTALL_DIR="$(dirname "${0}")"

# Install arch packages
sudo cat "${INSTALL_DIR}/pkglist.txt" | pacman -Syu --needed -

# Install yay if it does not already exist
if ! command -v yay > /dev/null 2>&1; then
  cd /tmp || exit 1
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit 1
  makepkg -si
fi

cd "${INSTALL_DIR}" || exit 1

# Install AUR packages
yay -Sa --noconfirm --needed - < "${INSTALL_DIR}/aurlist.txt"

# Deploy configs
./deploy.sh

