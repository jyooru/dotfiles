{ pkgs, ... }:

{
  imports = [ ./modules ./bin ];


  networking = {
    domain = "dev.joel.tokyo";
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
  };

  time.timeZone = "Australia/Brisbane";

  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "docker" "wheel" ];
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    trustedUsers = [ "root" "joel" ];
    binaryCaches = [
      "https://nix.ga-z77-d3h.dev.joel.tokyo"
      "https://nix.portege-r700-a.dev.joel.tokyo"
      "https://nix.portege-r700-b.dev.joel.tokyo"
      "https://nix.portege-z930.dev.joel.tokyo"
      "https://cache.nixos.org"
      "https://nix.thinkpad-e580.dev.joel.tokyo"
    ];
    binaryCachePublicKeys = with builtins; [
      (readFile ./hosts/ga-z77-d3h/binary-cache.pub)
      (readFile ./hosts/portege-r700-a/binary-cache.pub)
      (readFile ./hosts/portege-r700-b/binary-cache.pub)
      (readFile ./hosts/portege-z930/binary-cache.pub)
      (readFile ./hosts/thinkpad-e580/binary-cache.pub)
    ];
  };
  nixpkgs.config = import ./config/nixpkgs.nix;

  system = {
    autoUpgrade.enable = true;
    stateVersion = "21.05";
  };

  virtualisation.docker.enable = true;

  services.syncthing = {
    user = "joel";
    group = "users";
    configDir = "/home/joel/.config/syncthing";
    dataDir = "/home/joel";
    openDefaultPorts = true;
    systemService = true;
    overrideDevices = false;
    overrideFolders = false;
  };

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "204800";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      root = {
        programs.home-manager.enable = true;
        programs.ssh = { enable = true; matchBlocks = import ./config/ssh.nix; };
        nixpkgs.config = import ./config/nixpkgs.nix;
        xdg.configFile."nixpkgs/config.nix".source = ./config/nixpkgs.nix;
        home = {
          username = "root";
          homeDirectory = "/root";
          stateVersion = "21.11";
        };
      };
      joel = {
        programs.home-manager.enable = true;
        programs.ssh = { enable = true; matchBlocks = import ./config/ssh.nix; };
        nixpkgs.config = import ./config/nixpkgs.nix;
        xdg.configFile."nixpkgs/config.nix".source = ./config/nixpkgs.nix;
        xdg.configFile."btop/btop.conf".text = "theme_background = False";
        home = {
          username = "joel";
          homeDirectory = "/home/joel";
          stateVersion = "21.11";
        };
      };
    };
  };

  nixpkgs.overlays = [
    (pkgs: _: import ./pkgs { inherit pkgs; })
    (_: super: {
      nix-serve = super.nix-serve.override { nix = super.nix_2_3; }; # https://github.com/edolstra/nix-serve/issues/28
    })
    (_: super:
      {
        xsecurelock = super.xsecurelock.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [
            ./xsecurelock.patch
          ];
        });
      })
    (_: super: {
      steam = super.steam.override { extraProfile = "export DRI_PRIME=1"; };
    })
    (_: super: {
      minecraft = super.minecraft.overrideAttrs (_: {
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "minecraft-launcher";
            exec = "env DRI_PRIME=1 minecraft-launcher";
            icon = "minecraft-launcher";
            comment = "Official launcher for Minecraft, a sandbox-building game";
            desktopName = "Minecraft Launcher";
            categories = "Game;";
          })
        ];
      });
    })
  ];
}

