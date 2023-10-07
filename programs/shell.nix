{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra =
      if pkgs.stdenv.isDarwin
      then ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      ''
      else "";
  };

  programs.bash = {
    enable = true;
    initExtra =
      if pkgs.stdenv.isDarwin
      then ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      ''
      else "";
  };

  programs.fish = {
    enable = true;
    shellInit =
      if pkgs.stdenv.isDarwin
      then ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      ''
      else "";
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = {
        show_banner: false,
      }
    '';
    extraEnv =
      if pkgs.stdenv.isDarwin
      then ''
        $env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
      ''
      else "";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
