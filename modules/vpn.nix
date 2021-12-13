{ config, lib, ... }:

with lib;

let
  cfg = config.modules.vpn;

  lighthouseHostnameMap = {
    "portege-r700-a" = "10.42.0.11";
    "portege-r700-b" = "10.42.0.12";
    "portege-z930" = "10.42.0.13";
    "ga-z77-d3h" = "10.42.0.14";
  };
in

{
  options.modules.vpn = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };
  config = mkIf cfg.enable {
    services.nebula.networks."joel" = rec {
      # https://github.com/slackhq/nebula/blob/master/examples/config.yml
      enable = true;
      isLighthouse = elem config.networking.hostName (attrNames lighthouseHostnameMap);
      ca = "/etc/nebula/ca.crt";
      cert = "/etc/nebula/host.crt";
      key = "/etc/nebula/host.key";
      staticHostMap = removeAttrs
        {
          "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
          "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
          "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
          "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
        } [ (lighthouseHostnameMap.${config.networking.hostName} or "") ];
      lighthouses = lib.mkIf (!isLighthouse) (attrValues lighthouseHostnameMap);
      firewall = {
        outbound = [{ port = "any"; proto = "any"; host = "any"; }];
        inbound = [{ port = "any"; proto = "any"; host = "any"; }];
      };
      settings = {
        lighhouse.interval = 60;
        punchy.punch = true;
        cipher = "chachapoly";
        local_range = "192.168.0.0/24";
        tun = {
          disabled = false;
          dev = "nebula0";
          drop_local_broadcast = false;
          drop_multicast = false;
          tx_queue = 500;
          mtu = 1300;
        };
        firewall.conntrack = {
          tcp_timeout = "12m";
          udp_timeout = "3m";
          default_timeout = "10m";
          max_connections = 100000;
        };
      };
    };
  };
}

