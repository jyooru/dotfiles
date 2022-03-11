{ config, pkgs, self, ... }:

with builtins;

let
  hosts = attrNames self.nixosConfigurations;
  cacheHosts = filter (host: pathExists "${../../hosts}/${host}/keys/binary-cache.pub") hosts;
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
      trusted-public-keys =
        let
          currentKeys = map (x: readFile (../../. + "/hosts/${x}/keys/binary-cache.pub")) cacheHosts;
          oldKeys = map (replaceStrings [ ".joel.tokyo" ] [ ".dev.joel.tokyo" ]) currentKeys;
        in
        currentKeys ++ oldKeys;
    };
  };
  nixpkgs.config = import ./nixpkgs.nix;

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
