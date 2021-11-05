{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # apps
    brave # browser
    firefox # browser
    vscode # code editor
    signal-desktop # chat (family, friends)
    discord # chat (friends, public)
    gnome.nautilus # file manager (gui)
    ranger # file manager (tui)
    spotify # music streaming service
    obsidian # notes
    onlyoffice-bin # office suite
    libreoffice # office suite
    bitwarden # password manager
    darktable # photo editor and raw developer
    gimp # photo editor
    qimgv # photo viewer
    qbittorrent # torrent app

    # code
    nodePackages.prettier # * formatter
    caddy # caddyfile formatter and web server
    python3 # python
    python3Packages.black # python formatter
    python3Packages.flake8 # python linter
    python3Packages.isort # python import formatter
    python3Packages.mypy # python type checker
    python3Packages.poetry # python package manager
    python3Packages.pytest # python test framework
    nixpkgs-fmt # nix formatter
    nixpkgs-review # nixpkgs pull request reviewing tool

    # desktop environment
    polybar # bar
    picom # compositor
    fira-code # font
    rofi # launcher
    betterlockscreen # lock screen
    alacritty # terminal emulator
    starship # terminal prompt
    bspwm # window manager

    # optional dependencies
    file # for preview in ranger
    python3Packages.chardet # for preview in ranger
    highlight # for preview in ranger
    unzip # for preview in ranger
    python3Packages.pdftotext # for preview in ranger
    mediainfo # for preview in ranger
    odt2txt # for preview in ranger

    # tools
    brightnessctl # brightness control
    dig # dns lookup
    pandoc # document converter
    ncdu # disk space viewer
    p7zip # file archiver, optional dependecy for preview in ranger
    fd # "find" rust alternative
    ffsend # file sender
    gh # github cli
    httpie # http cli
    iotop # I/O monitor
    jq # json cli
    killall # kill processes by name
    lsd # "ls" rust alternative
    tree # list directories recursively
    docker-compose # manage multi-container applications
    cmatrix # matrix display
    playerctl # media player control
    ffmpeg # media converter
    youtube-dl # media downloader # TODO: yt-dlp
    sshfs # mount filesystems over ssh
    pv # pipe progress monitor
    nmap # port scanner
    scrot # screenshot
    lm_sensors # sensor viewer
    neofetch # system info
    htop # system usage monitor # TODO: btop
    wmctrl # window manager control
    xorg.xev # x event viewer
    git # version control system
    whois # whois viewer
  ];
}
