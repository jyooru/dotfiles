{ config, lib, pkgs, ... }:

with lib;

let
  port = (import ./ports.nix).${config.networking.hostName};
  port' = toString port;
in

{
  environment.variables.IPFS_PATH = config.services.ipfs.dataDir;

  networking.firewall.interfaces."ygg0" = {
    allowedTCPPorts = [ port ];
    allowedUDPPorts = [ port ];
  };

  services.ipfs = {
    enable = true;
    enableGC = true;
    emptyRepo = true; # no help files
    localDiscovery = true;
    swarmAddress = [
      "/ip4/0.0.0.0/tcp/${port'}"
      "/ip6/::/tcp/${port'}"
      "/ip4/0.0.0.0/udp/${port'}/quic"
      "/ip6/::/udp/${port'}/quic"
    ];

    extraConfig.Peering.Peers = map
      (ID: { inherit ID; }) # IPFS will query DHT for addresses
      (attrValues (removeAttrs (import ./peers.nix) [ config.networking.hostName ]));
  };

  systemd.services.ipfs.serviceConfig.ExecStartPost = "${pkgs.coreutils}/bin/chmod g+r /var/lib/ipfs/config";
}
