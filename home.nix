{ config, pkgs, ... }:

{
  imports = [ ./services/x11/window-managers/bspwm.nix ];

  programs.home-manager.enable = true;

  home = {
    username = "joel";
    homeDirectory = "/home/joel";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.11";
  };

  services.syncthing.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "\$HOME/desktop";
    documents = "\$HOME/documents";
    download = "\$HOME/downloads";
    music = "\$HOME/media/music";
    pictures = "\$HOME/media/screenshots";
    publicShare = "\$HOME/share";
    templates = "\$HOME/templates";
    videos = "\$HOME/media/videos";
  };
}
