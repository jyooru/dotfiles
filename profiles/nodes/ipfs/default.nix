{ config, lib, pkgs, ... }:

with lib;

let
  inherit (config.networking) fqdn hostName;

  gateway = splitString "/" config.services.ipfs.gatewayAddress;
  ports = unique (map
    (address: toInt (elemAt (splitString "/" address) 4))
    config.services.ipfs.swarmAddress);
  allowedPorts = {
    allowedTCPPorts = ports;
    allowedUDPPorts = ports;
  };
in

{
  environment.sessionVariables.IPFS_PATH = config.services.ipfs.dataDir;

  networking.firewall = {
    interfaces = genAttrs [ "nebula0" "ygg0" ] (_: allowedPorts);
    lan = allowedPorts;
  };

  services = {
    caddy.virtualHosts."ipfs.${fqdn}".extraConfig = ''
      import tls
      reverse_proxy ${elemAt gateway 2}:${elemAt gateway 4}
    '';

    ipfs = {
      enable = true;
      enableGC = true;
      emptyRepo = true; # no help files
      localDiscovery = true;

      extraConfig = {
        Peering.Peers = map
          (ID: { inherit ID; }) # IPFS will query DHT for addresses
          (attrValues (removeAttrs (import ./peers.nix) [ hostName ]));
        Swarm.ConnMgr = {
          # my router can't handle all these connections
          HighWater = 400;
          LowWater = 200;
        };
      };
    };
  };

  systemd.services.ipfs.serviceConfig.ExecStartPost = "${pkgs.coreutils}/bin/chmod g+r /var/lib/ipfs/config";
}
