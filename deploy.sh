#!/bin/sh

GREEN="$(printf "%s%s" "$(tput bold)" "$(tput setaf 2)")"
RESET="$(tput sgr0)"
log() {
  printf "%s%s%s" "${GREEN}" "${1}" "${RESET}"
  # log any other arguments
  shift
  for arg in "$@"
  do
    printf " %s" "${arg}"
  done
  printf "\n"
}

REPO_DIR="$(realpath "$(dirname "$0")")"
FILES="$(cd "${REPO_DIR}" && find .local .config .zshenv -type f)"

# Clean some folders we frequently change the contents of
rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.config/zsh"

for file in ${FILES}
do
  log Deploying "${file}"
  mkdir -p "$(dirname "$HOME/$file")"
  ln -sf "$REPO_DIR/$file" "$HOME/$file"
done

