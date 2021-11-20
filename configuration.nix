{ pkgs, ... }:

{
  imports = import ./modules/module-list.nix ++ [ ./bin ];

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  i18n.defaultLocale = "en_AU.UTF-8";

  networking = {
    firewall = {
      enable = true;
      # allowedTCPPorts = [ ];
      # allowedUDPPorts = [ ];
    };
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
  };

  services = {
    auto-cpufreq.enable = true;

    logind = {
      lidSwitch = "ignore";
      extraConfig = ''
        HandlePowerKey=ignore
      '';
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
    };

    xserver = {
      enable = true;

      desktopManager = { xterm.enable = false; };
      displayManager = { defaultSession = "none+bspwm"; };
      windowManager.bspwm = { enable = true; };

      libinput.enable = true; # touchpad
      layout = "au";
    };
  };

  time.timeZone = "Australia/Brisbane";

  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "docker" "wheel" ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.enable = true;
    steam.enable = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config = import ./config/nixpkgs.nix;

  system = {
    autoUpgrade.enable = true;
    stateVersion = "21.05";
  };

  virtualisation.docker.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.joel = {

      programs.home-manager.enable = true;

      nixpkgs.config = import ./config/nixpkgs.nix;
      xdg.configFile."nixpkgs/config.nix".source = ./config/nixpkgs.nix;

      home = {
        username = "joel";
        homeDirectory = "/home/joel";

        stateVersion = "21.11";
      };

      services.syncthing.enable = true;

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "\$HOME/desktop";
        documents = "\$HOME/documents";
        download = "\$HOME/downloads";
        music = "\$HOME/media/music";
        pictures = "\$HOME/media/screenshots";
        publicShare = "\$HOME/share";
        templates = "\$HOME/templates";
        videos = "\$HOME/media/videos";
      };
    };
  };
}

