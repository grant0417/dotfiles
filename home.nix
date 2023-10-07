{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programs
  ];

  home.stateVersion = "23.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    zsh
    fish
    bash

    git
    neovim
    rustup

    eza
    bat
    fd
    ripgrep
    jq

    nixfmt
    nil

    bitwarden-cli

    (pkgs.writeShellScriptBin "home-switch" ''
      cd ~/dotfiles && git add .
      home-manager switch --flake ~/dotfiles "$@"
    '')

    (pkgs.writeShellScriptBin "home-build" ''
      cd ~/dotfiles && git add .
      home-manager build --flake ~/dotfiles "$@"
    '')

    (pkgs.writeShellApplication {
      name = "download-audio";
      runtimeInputs = [yt-dlp];
      text = builtins.readFile ./bin/download-audio;
    })

    (pkgs.writeShellScriptBin "batch-download-audio"
      (builtins.readFile ./bin/batch-download-audio))

    (pkgs.writeShellApplication {
      name = "sbw";
      runtimeInputs = [libsecret bitwarden];
      text = ''
        if [ "$#" -eq 1 ] && [ "$1" = "login" ]; then
          bw login --raw | secret-tool store --label="Bitwarden" bitwarden session
        else
          BW_SESSION=$(secret-tool lookup bitwarden session) bw "$@"
        fi
      '';
    })
  ];

  xdg.enable = true;

  home.shellAliases = {
    ls = "eza";
    l = "eza --git --git-repo";
  };

  home.file = {
    ".config" = {
      source = ./config;
      recursive = true;
    };

    ".local" = {
      source = ./local;
      recursive = true;
    };
  };

  home.sessionVariables = let
    commonVars = {
      EDITOR = "nvim";
      TERMINAL = "wezterm";
      READER = "zathura";
      PAGER = "less";
      BROWSER = "firefox-developer-edition";

      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      GOPATH = "${config.xdg.dataHome}/go";
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    };
    linuxVars = {OS = "linux";};
    darwinVars = {OS = "darwin";};
  in
    commonVars
    // (
      if pkgs.stdenv.isLinux
      then linuxVars
      else if pkgs.stdenv.isDarwin
      then darwinVars
      else {}
    );

  programs.vscode.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
