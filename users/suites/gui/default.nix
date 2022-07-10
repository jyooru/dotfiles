{
  imports = [
    ../../profiles/browsers/librewolf
    ../../profiles/compositors/picom
    ../../profiles/editors/vscode
    ../../profiles/file-managers/ranger
    ../../profiles/launchers/rofi
    ../../profiles/media-players/termusic
    ../../profiles/notification-daemons/dunst
    ../../profiles/terminal-emulators/alacritty
    ../../profiles/packages/apps.nix
    ../../profiles/packages/code.nix
    ../../profiles/window-managers/qtile

    ../base
  ];

  xdg.userDirs = {
    enable = true;
    desktop = "$HOME/desktop";
    documents = "$HOME/documents";
    download = "$HOME/downloads";
    music = "$HOME/media/music";
    pictures = "$HOME/media/screenshots";
    publicShare = "$HOME/share";
    templates = "$HOME/templates";
    videos = "$HOME/media/videos";
  };
}
