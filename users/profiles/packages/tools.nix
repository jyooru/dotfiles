{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bandwhich # bandwidth monitor
    brightnessctl # brightness control
    pastel # colors cli
    dogdns # dns lookup
    pandoc # document converter
    broot # directory viewer
    ncdu # disk space viewer
    nix-du # disk space viewer for nix store
    ddgr # duckduckgo cli
    p7zip # file archiver, optional dependecy for preview in ranger
    fd # "find" rust alternative
    ffsend # file sender
    gh # github cli
    graphviz # graphing tools
    hexyl # hex viewer
    httpie # http cli
    iotop # I/O monitor
    ipinfo # ipinfo cli
    jq # json cli
    killall # kill processes by name
    lsd # "ls" rust alternative
    tree # list directories recursively
    docker-compose # manage multi-container applications
    cmatrix # matrix display
    playerctl # media player control
    ffmpeg # media converter
    yt-dlp # media downloader
    sshfs # mount filesystems over ssh
    manix # nix documentation cli
    gping # ping but with a graph
    pv # pipe progress monitor
    nmap # port scanner
    scrot # screenshot
    lm_sensors # sensor viewer
    neofetch # system info
    btop # system monitor
    htop # system monitor
    aircrack-ng # wifi tools
    wmctrl # window manager control
    xorg.xev # x event viewer
    git # version control system
    whois # whois viewer

    timetable # packages/timetable
  ];
}
