#!/bin/sh

REPO_DIR="$(dirname "$0")"
FILES="$(cd $REPO_DIR && find .local .config .zshenv -type f)"

for file in ${FILES}
do
  echo "Deploying: '$file'"
  mkdir -p "$(dirname "$HOME/$file")"
  rm -f "$HOME/$file"
  ln "$REPO_DIR/$file" "$HOME/$file"
done

