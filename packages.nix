{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    python3
    sshfs
    dig
    htop
    git
    brave
    fira-code
    vscode
    gimp
    obsidian
    signal-desktop
    discord
    spotify
    qbittorrent
    onionshare
    bitwarden
    bitwarden-cli
    starship
    killall
    scrot
    neofetch
    cmatrix
    bspwm
    alacritty
    polybar
    rofi
    wmctrl
    gnome.nautilus
    lsd
    ranger
    pv
    ncdu
    ffmpeg
    nmap
    iotop
    pandoc
    picom
    fd
    ffsend
    brightnessctl
    xorg.xev
    playerctl
    nixpkgs-fmt
    darktable
    qimgv
    betterlockscreen
    docker-compose
    python3Packages.black
    python3Packages.flake8
    python3Packages.isort
    python3Packages.mypy
    python3Packages.poetry
    python3Packages.pytest
    file
    python3Packages.chardet
    highlight
    p7zip
    unzip
    python3Packages.pdftotext
    mediainfo
    odt2txt
    nodePackages.prettier
    # TODO: yt-dlp
  ];
}
