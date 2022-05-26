#!/bin/sh

REPO_DIR="$(realpath $(dirname "$0"))"
FILES="$(cd $REPO_DIR && find .local .config .zshenv -type f)"

for file in ${FILES}
do
  echo "Deploying: '$file'"
  mkdir -p "$(dirname "$HOME/$file")"
  ln -sf "$REPO_DIR/$file" "$HOME/$file"
done

