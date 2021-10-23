{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox # browser
    python3 # programming language
    sshfs # mount filesystems over ssh
    dig # dns lookup
    htop # system usage monitor
    git # version control system
    brave # browser 
    fira-code # monspace font
    vscode # code editor
    gimp # photo editor
    obsidian # note app
    signal-desktop # chat app (family, friends)
    discord # chat app (friends, public)
    spotify # music streaming service
    qbittorrent # torrent app
    bitwarden # password manager
    starship # terminal prompt
    killall
    scrot # screenshotter
    neofetch
    cmatrix
    bspwm # window manager
    alacritty # terminal emulator
    polybar # bar
    rofi # launcher
    wmctrl # cli tool for interacting with window manager
    gnome.nautilus # file manager
    lsd # pretty ls alternative
    ranger # terminal file manager
    pv # pipe progress monitor
    ncdu # disk space viewer
    ffmpeg # video converter
    nmap # port scanner
    iotop # I/O monitor
    pandoc # document converter
    picom # compositor
    fd # find alternative
    ffsend # firefox send cli
    brightnessctl # control laptop screen brightness
    xorg.xev # tool to get x key press names
    playerctl # tool to control music playing
    nixpkgs-fmt # nix formatter
    darktable # raw developer
    qimgv # photo viewer
    betterlockscreen # lock screen
    docker-compose # tool to manage multi-container applications
    python3Packages.black # python formatter
    python3Packages.flake8 # python linter
    python3Packages.isort # python import formatter
    python3Packages.mypy # python type checker
    python3Packages.poetry # python package manager
    python3Packages.pytest # python test framework
    p7zip # file archiver, optional dependecy for preview in ranger

    # ranger preview
    file # optional dependecy for preview in ranger
    python3Packages.chardet # optional dependecy for preview in ranger
    highlight # optional dependecy for preview in ranger
    unzip # optional dependecy for preview in ranger
    python3Packages.pdftotext # optional dependecy for preview in ranger
    mediainfo # optional dependecy for preview in ranger
    odt2txt # optional dependecy for preview in ranger

    nodePackages.prettier # formatter
    onlyoffice-bin # office suite
    libreoffice # office suite
    lm_sensors # temperature monitor
    caddy # caddy fmt for vscode extension
    gh # github cli
    whois
    jq # cli json processor
    tree
    youtube-dl # until i get yt-dlp working
    httpie # http cli
    # TODO: (on unstable) yt-dlp, btop
  ];
}
