{ config, self, ... }:
let
  inherit (builtins) attrNames listToAttrs pathExists;
  inherit (config.networking) hostName;

  hosts = (attrNames self.nixosConfigurations) ++ [ "retropie" ];
in
{
  services.openssh = {
    enable = pathExists "${../hosts}/${hostName}/keys/ssh.pub";
    passwordAuthentication = false;
  };

  programs.ssh.knownHosts = listToAttrs (map
    (name: {
      inherit name;
      value = { publicKeyFile = ../hosts + "/${name}/keys/ssh.pub"; };
    })
    hosts);
}
