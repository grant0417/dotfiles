#!/bin/sh

DEPLOY_DIR=$(dirname $0)/
rsync --exclude ".git/" --exclude "deploy.sh"  --exclude "screenshots" --exclude "README.md" --exclude "pkglist.txt" --exclude "aurlist.txt" --exclude "install_deploy.sh" --exclude "setup_system.sh" -avhE --no-perms $DEPLOY_DIR $HOME
