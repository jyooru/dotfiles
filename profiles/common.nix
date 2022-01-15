{ config, pkgs, self, ... }:
let
  hosts = builtins.attrNames self.nixosConfigurations;
in
{
  users.mutableUsers = true;

  services = {
    logind = {
      lidSwitch = "ignore";
      extraConfig = ''
        HandlePowerKey=ignore
      '';
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    trustedUsers = [ "root" "joel" ];
    binaryCaches = map (x: "https://nix.${x}.${config.networking.domain}") hosts;
    binaryCachePublicKeys = map (x: builtins.readFile (../. + "/hosts/${x}/binary-cache.pub")) hosts;
  };
  nixpkgs.config = import ../config/nixpkgs.nix;

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
          nixpkgs.config = import ../config/nixpkgs.nix;
          xdg.configFile."nixpkgs/config.nix".source = ../config/nixpkgs.nix;
          xdg.configFile."btop/btop.conf".text = "theme_background = False";
          home.stateVersion = "21.11";
        };
      in
      {
        root = defaults;
        joel = defaults;
      };
  };

  nixpkgs.overlays = builtins.attrValues (import ../overlays);
}
