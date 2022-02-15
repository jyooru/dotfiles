{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl # brightness control
    dig # dns lookup
    pandoc # document converter
    ddgr # duckduckgo cli
    ncdu # disk space viewer
    p7zip # file archiver, optional dependecy for preview in ranger
    fd # "find" rust alternative
    ffsend # file sender
    gh # github cli
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
    pv # pipe progress monitor
    nmap # port scanner
    scrot # screenshot
    lm_sensors # sensor viewer
    neofetch # system info
    btop # system monitor
    htop # system monitor
    wmctrl # window manager control
    xorg.xev # x event viewer
    git # version control system
    whois # whois viewer

    timetable # packages/timetable
  ];
}
