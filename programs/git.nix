{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "Grant Gurvis";
    userEmail = "grant@gurvis.net";

    # delta = {
    #   enable = true;
    #   options = {
    #     light = false;
    #   };
    # };

    difftastic = {
      enable = true;
      background = "dark";
    };

    ignores = [".DS_Store"];

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      rebase.autosquash = true;
      push.default = "simple";
      push.autoSetupRemote = true;
      status.displaycommentprefix = true;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
