{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave # browser
    signal-desktop # chat (family, friends)
    discord # chat (friends, public)
    gnome.nautilus # file manager (gui)
    ranger # file manager (tui)
    minecraft # game
    arduino # ide for arduino
    vlc # media player
    spotify # music streaming service
    obsidian # notes
    onlyoffice-bin # office suite
    libreoffice # office suite
    bitwarden # password manager
    darktable # photo editor and raw developer
    gimp # photo editor
    qimgv # photo viewer
    qbittorrent # torrent app
    openshot-qt # video editor
  ];
}
