{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.packages;
in

{
  options.modules.packages = with types; {
    apps = mkOption {
      type = bool;
      default = false;
      description = "Install apps";
    };
    code = mkOption {
      type = bool;
      default = false;
      description = "Install code tools";
    };
    desktopEnvironment = mkOption {
      type = bool;
      default = false;
      description = "Install desktop environment";
    };
    tools = mkOption {
      type = bool;
      default = false;
      description = "Install tools";
    };
  };
  config = {
    environment.systemPackages = with pkgs; [
    ]

    ++ optionals cfg.apps [
      brave # browser
      firefox # browser
      signal-desktop # chat (family, friends)
      discord # chat (friends, public)
      gnome.nautilus # file manager (gui)
      spotify # music streaming service
      obsidian # notes
      onlyoffice-bin # office suite
      libreoffice # office suite
      bitwarden # password manager
      darktable # photo editor and raw developer
      gimp # photo editor
      qimgv # photo viewer
      qbittorrent # torrent app
    ]

    ++ optionals cfg.code [
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
    ]

    ++ optionals cfg.desktopEnvironment [
      picom # compositor
      fira-code # font
    ]

    ++ optionals cfg.tools [
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
      whois # whois viewer
    ];
  };
}
