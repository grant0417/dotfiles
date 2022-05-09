#!/bin/sh

GREEN="$(printf "$(tput bold)$(tput setaf 2)")"
RESET="$(tput sgr0)"
function log {
  echo "${GREEN}${1}${RESET}"
}

if command -v systemctl &> /dev/null; then
  log 'Setting up systemctl services'
  sudo systemctl enable --now systemd-timesyncd.service
else 
  log 'Skipping systemctl setup'
fi

log 'Installing nvim plugins'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

log 'Done!'

