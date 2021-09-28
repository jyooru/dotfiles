{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "joel";
  home.homeDirectory = "/home/joel";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  programs.git = {
    enable = true;
    signing.key = "33CA5F24";
    signing.signByDefault = true;
    userEmail = "joel@joel.tokyo";
    userName = "Joel";
    includes = [{
      contents = {
        init = { defaultBranch = "main"; };
        push = { default = "current"; };
        pull = { rebase = true; };
      };
    }];
  };
}
