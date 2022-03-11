{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave # browser
    signal-desktop # chat (family, friends)
    discord # chat (friends, public)
    gnome.nautilus # file manager (gui)
    ranger # file manager (tui)
    arduino # ide for arduino
    vlc # media player
    polymc # minecraft launcher
    openjdk8 # minecraft java version
    # openjdk17 # minecraft java version
    spotify # music streaming service
    obsidian # notes
    onlyoffice-bin # office suite
    libreoffice # office suite
    bitwarden # password manager
    scribusUnstable # pdf editor - stable version uses insecure python 2.7 pillow
    darktable # photo editor and raw developer
    gimp # photo editor
    qimgv # photo viewer
    qbittorrent # torrent app
    openshot-qt # video editor
  ];
}
