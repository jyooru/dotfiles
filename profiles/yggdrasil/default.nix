{ config, lib, self, ... }:

with builtins;
with lib;

let
  inherit (config.networking) hostName;

  ports = import ./ports.nix;
in

{
  networking.firewall = {
    allowedTCPPorts = [ 20070 ];
    interfaces."ygg0".allowedTCPPorts = [
      4244 # alfis
    ];
  };

  services.yggdrasil = {
    enable = true;
    group = "wheel";
    persistentKeys = true;
    openMulticastPort = true;
    config = {
      Listen =
        if hasAttr hostName ports then
          [ "tls://[::]:${toString ports.${hostName}}" ]
        else
          [ ];
      Peers = [
        "tls://01.sgp.sgp.ygg.yt:443" # asia, singapore, 128ms
        "tls://01.blr.ind.ygg.yt:443" # asia, india, 166ms
        "tls://01.scv.usa.ygg.yt:443" # north america, united states, 174ms
        "tls://01.tky.jpn.ygg.yt:443" # asia, japan, 177ms
        "tls://tasty.chowder.land:9001" # north america, united states, 177ms
        "tls://ygg-nv-us.incognet.io:8884" # north america, united states, 180ms
      ];
      MulticastInterfaces = [{
        Regex = ".*";
        Beacon = true;
        Listen = true;
        Port = 20070;
      }];
      IfName = "ygg0";
      NodeInfo.name = "${hostName}.joel.ygg";
    };
  };
}
