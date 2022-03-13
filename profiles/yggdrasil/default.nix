{ config, ... }:
{
  services.yggdrasil = {
    enable = true;
    group = "wheel";
    persistentKeys = true;
    config = {
      Peers = [
        "tls://01.tky.jpn.ygg.yt:443"
        "tls://01.sgp.sgp.ygg.yt:443"
        "tls://167.160.89.98:7040"
      ];
      IfName = "ygg0";
      NodeInfo.name = config.networking.fqdn;
    };
  };
}
