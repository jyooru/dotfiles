{ config, ... }:
let
  inherit (builtins) listToAttrs pathExists;
in
{
  services.openssh = {
    enable = pathExists (../hosts + "/${config.networking.hostName}/host.pub");
    passwordAuthentication = false;
  };

  programs.ssh.knownHosts = listToAttrs (map (name: { inherit name; value = { publicKeyFile = ../hosts + "/${name}/host.pub"; }; }) (import ../tmp-hosts.nix));
}
