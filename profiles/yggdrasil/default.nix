{ config, lib, self, ... }:

with builtins;
with lib;

let
  inherit (config.networking) hostName;

  ports = import ./ports.nix;
  isPublicPeer = hasAttr hostName ports;
  myPeers = mapAttrsToList
    (_: port: "tls://home.joel.tokyo:${toString port}")
    (filterAttrs (name: _: name != hostName) ports);

  othersPeers = [
    # behold, australia's latency to the rest of the world
    "tls://01.sgp.sgp.ygg.yt:443" # singapore, 131ms
    "tls://01.blr.ind.ygg.yt:443" # india, 168ms
    "tls://01.tky.jpn.ygg.yt:443" # japan, 174ms
    "tls://01.scv.usa.ygg.yt:443" # usa, 176ms
    # some more so im not dependant on ygg.yt
    "tls://167.160.89.98:7040" # usa, 200ms
    "tls://bazari.sh:3725" # usa, 205ms
    "tls://ygg-tx-us.incognet.io:8883" # usa, 208ms
    "tls://108.175.10.127:61216" # usa, 236ms
  ];
in

{
  networking.firewall.allowedTCPPorts = [ 20070 ];

  services.yggdrasil = {
    enable = true;
    group = "wheel";
    persistentKeys = true;
    config = {
      Listen =
        if isPublicPeer then
          [ "tls://[::]:${toString ports.${hostName}}" ]
        else
          [ ];
      Peers = if isPublicPeer then myPeers ++ othersPeers else myPeers;
      MulticastInterfaces = [{
        Regex = ".*";
        Beacon = true;
        Listen = true;
        Port = 20070;
      }];
      IfName = "ygg0";
      NodeInfo.name = "y.${config.networking.fqdn}";
    };
  };
}
