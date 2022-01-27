{ config, self, ... }:
let
  inherit (builtins) attrNames listToAttrs pathExists;
  inherit (config.networking) hostName;

  hosts = (attrNames self.nixosConfigurations) ++ [ "retropie" ];
in
{
  services.openssh = {
    enable = pathExists (../hosts + "/${hostName}/host.pub");
    passwordAuthentication = false;
  };

  programs.ssh.knownHosts = listToAttrs (map (name: { inherit name; value = { publicKeyFile = ../hosts + "/${name}/host.pub"; }; }) hosts);
}
