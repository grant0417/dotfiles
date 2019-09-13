#/bin/sh

rsync --exclude ".git/" --exclude "deploy.sh" -avh --no-perms . ~
