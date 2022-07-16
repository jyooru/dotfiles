{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nakatoshi # bitcoin vanity address generator
    brightnessctl # brightness control
    kalker # calculator
    pastel # colors cli
    brotli # compression format
    dogdns # dns lookup
    pandoc # document converter
    broot # directory viewer
    ncdu # disk space viewer
    ddgr # duckduckgo cli
    p7zip # file archiver, optional dependecy for preview in ranger
    fd # "find" rust alternative
    ffsend # file sender
    gh # github cli
    graphviz # graphing tools
    hexyl # hex viewer
    httpie # http cli
    ipinfo # ipinfo cli
    jisho-api # jisho cli
    jq # json cli
    killall # kill processes by name
    lsd # "ls" rust alternative
    tree # list directories recursively
    atto # nano cli wallet
    nano-vanity # nano vanity address generator
    docker-compose # manage multi-container applications
    tldr # manuals
    cmatrix # matrix display
    playerctl # media player control
    ffmpeg # media converter
    yt-dlp # media downloader
    sshfs # mount filesystems over ssh
    manix # nix documentation cli
    gping # ping but with a graph
    pv # pipe progress monitor
    nmap # port scanner
    qrencode # qr code generator
    scrot # screenshot
    lm_sensors # sensor viewer
    spotdl # spotify downloader
    sysz # systemctl fuzzy finder
    neofetch # system info
    btop # system monitor
    htop # system monitor
    aircrack-ng # wifi tools
    wmctrl # window manager control
    xorg.xev # x event viewer
    simpleygggen-cpp # yggdrasil vanity address generator
    git # version control system
    vanieth # ethereum vanity address generator
    vanity-monero # monero vanity address generator
    sshuttle # vpn over ssh
    whois # whois viewer

    timetable # packages/timetable
  ];
}
