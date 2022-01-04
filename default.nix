{ config, pkgs, ... }:

{
  imports = [ ./modules ./bin ];

  networking = {
    domain = "dev.joel.tokyo";
    firewall.enable = true;
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
  };

  users.mutableUsers = true;

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

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    trustedUsers = [ "root" "joel" ];
    binaryCaches = map (x: "https://nix.${x}.${config.networking.domain}") (import ./tmp-hosts.nix);
    binaryCachePublicKeys = map (x: builtins.readFile (./. + "/hosts/${x}/binary-cache.pub")) (import ./tmp-hosts.nix);
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
    users =
      let
        defaults = {
          programs.home-manager.enable = true;
          programs.ssh = { enable = true; matchBlocks = import ./config/ssh.nix; };
          nixpkgs.config = import ./config/nixpkgs.nix;
          xdg.configFile."nixpkgs/config.nix".source = ./config/nixpkgs.nix;
          xdg.configFile."btop/btop.conf".text = "theme_background = False";
          home.stateVersion = "21.11";
        };
      in
      {
        root = defaults;
        joel = defaults;
      };
  };

  programs.ssh.knownHosts = builtins.listToAttrs (map (name: { inherit name; value = { publicKeyFile = ./hosts + "/${name}/host.pub"; }; }) (import ./tmp-hosts.nix));

  nixpkgs.overlays = builtins.attrValues (import ./overlays);
}
