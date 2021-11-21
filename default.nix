{ pkgs, ... }:

{
  imports = import ./modules/module-list.nix ++ [ ./bin ];


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
    };
  };
}
