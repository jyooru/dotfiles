{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave # backup browser
    signal-desktop # chat (family, friends)
    discord # chat (friends, public)
    alfis # decentralised free blockchain domain name system
    gnome.nautilus # file manager (gui)
    ranger # file manager (tui)
    anki-bin # flashcards
    mindustry # game
    arduino # ide for arduino
    vlc # media player
    polymc # minecraft launcher
    jdk # minecraft java version
    obsidian # notes
    onlyoffice-bin # office suite
    libreoffice # office suite
    bitwarden # password manager
    scribus # pdf editor
    darktable # photo editor and raw developer
    gimp # photo editor
    qimgv # photo viewer
    inkscape # svg editor
    qbittorrent # torrent app
    openshot-qt # video editor
  ];
}
