{ config, self, ... }:
let
  inherit (builtins) attrNames listToAttrs pathExists;
  inherit (config.networking) hostName;

  hosts = (attrNames self.nixosConfigurations) ++ [ "retropie" ];
in
{
  networking.firewall.interfaces.nebula0.allowedTCPPorts = config.services.openssh.ports;

  programs.ssh.knownHosts = listToAttrs (map
    (name: {
      inherit name;
      value = { publicKeyFile = ../../hosts + "/${name}/keys/ssh.pub"; };
    })
    hosts);

  services.openssh = {
    enable = pathExists "${../../hosts}/${hostName}/keys/ssh.pub";
    openFirewall = false;
    passwordAuthentication = false;
  };
}
