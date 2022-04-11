{ config, inputs, lib, pkgs, self, ... }:

with lib;

let
  hosts = attrNames self.nixosConfigurations;
  cacheHosts = filter (host: (pathExists "${../../hosts}/${host}/keys/binary-cache.pub") && (host != config.networking.hostName)) hosts;
  currentKeys = map (x: readFile (../../. + "/hosts/${x}/keys/binary-cache.pub")) cacheHosts;
  oldKeys = map (replaceStrings [ ".joel.tokyo" ] [ ".dev.joel.tokyo" ]) currentKeys;
  trusted-public-keys = currentKeys ++ oldKeys;
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
    settings = {
      trusted-users = [ "root" "joel" ];
      substituters = map (x: "https://nix.${x}.${config.networking.domain}") cacheHosts;
      inherit trusted-public-keys;
    };

    # flake-utils-plus
    generateRegistryFromInputs = true;
    generateNixPathFromInputs = true;
    linkInputs = true;
  };
  nixpkgs.config = import ./nixpkgs.nix;

  system = {
    autoUpgrade.enable = true;
    stateVersion = "21.05";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users =
      let
        defaults = {
          programs.home-manager.enable = true;
          nixpkgs.config = import ./nixpkgs.nix;
          xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;
          xdg.configFile."btop/btop.conf".text = "theme_background = False";
          home.stateVersion = "21.11";
        };
      in
      {
        root = defaults;
        joel = defaults;
      };
  };
}
