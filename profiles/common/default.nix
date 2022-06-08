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

  environment.sessionVariables.EDITOR = "hx";

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

  programs.ssh.knownHosts = listToAttrs (map
    (name: {
      inherit name;
      value = { publicKeyFile = ../../hosts + "/${name}/keys/ssh.pub"; };
    })
    hosts);

  system.stateVersion = "21.05";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
