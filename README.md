# Grant's Dotfiles

<!-- Ancient screenshot, should probably update this -->
<!-- ![Desktop Screenshot 1](screenshots/desktop1.jpg) -->

These dots are managed with
[home-manager](https://github.com/nix-community/home-manager)

# How to use

First install the following packages:

```shell
sudo pacman -S --needed nix git

# setup nix on arch
cat <<EOF | sudo tee -a /etc/nix/nix.conf
max-jobs = auto
experimental-features = nix-command flakes
EOF
sudo systemctl enable nix-daemon.socket
sudo usermod -aG nix-users $USER

# update nix
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update

git clone https://github.com/grant0417/dotfiles.git ~/.dotfiles
nix run home-manager/master -- init --switch ~/dotfiles
```

After that start a new shell and all future modifications can be done with
`home-switch`.
