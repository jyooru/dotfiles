{ config, lib, pkgs, self, ... }:

with lib;

let
  hosts = attrNames self.nixosConfigurations;
  cacheHosts = filter (host: (pathExists "${../../hosts}/${host}/keys/binary-cache.pub") && (host != config.networking.hostName)) hosts;
  currentKeys = map (x: readFile (../../. + "/hosts/${x}/keys/binary-cache.pub")) cacheHosts;
  oldKeys = map (replaceStrings [ ".joel.tokyo" ] [ ".dev.joel.tokyo" ]) currentKeys;
  trusted-public-keys = currentKeys ++ oldKeys;
in

{
  imports = [ ./locale.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = ca-derivations flakes nix-command
    '';
    settings = {
      trusted-users = [ "root" "@wheel" ];
      substituters = map (x: "https://nix.${x}.${config.networking.domain}") cacheHosts;
      inherit trusted-public-keys;
    };

    # flake-utils-plus
    generateRegistryFromInputs = true;
    generateNixPathFromInputs = true;
    linkInputs = true;
  };

  nixpkgs.config = import ./nixpkgs.nix;

  programs = {
    bandwhich.enable = true;
    iotop.enable = true;

    ssh.knownHosts = listToAttrs (map
      (name: {
        inherit name;
        value = { publicKeyFile = ../../hosts + "/${name}/keys/ssh.pub"; };
      })
      hosts);
  };

  services = {
    logind = {
      lidSwitch = "ignore";
      extraConfig = ''
        HandlePowerKey=ignore
      '';
    };
  };

  system.stateVersion = "21.05";

  users.mutableUsers = true;
}
