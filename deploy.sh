#/bin/sh

DEPLOY_DIR=$(dirname $0)/
rsync --exclude ".git/" --exclude "deploy.sh"  --exclude "screenshots" --exclude "README.md" -avh --no-perms $DEPLOY_DIR $HOME
