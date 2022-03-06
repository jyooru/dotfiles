{ config, lib, ... }:

let
  inherit (lib) attrNames attrValues elem mkIf;
  inherit (config.networking) hostName;

  lighthouses = {
    "portege-r700-a" = "10.42.0.11";
    "portege-r700-b" = "10.42.0.12";
    "portege-z930" = "10.42.0.13";
    "ga-z77-d3h" = "10.42.0.14";
  };
  lighthouseHostnames = attrNames lighthouses;
  lighthouseIps = attrValues lighthouses;
  staticHosts = {
    "10.42.0.11" = [ "home.joel.tokyo:4241" "192.168.0.11:4241" ];
    "10.42.0.12" = [ "home.joel.tokyo:4242" "192.168.0.12:4242" ];
    "10.42.0.13" = [ "home.joel.tokyo:4243" "192.168.0.13:4243" ];
    "10.42.0.14" = [ "home.joel.tokyo:4244" "192.168.0.14:4244" ];
  };
in

{
  services.nebula.networks."joel" = rec {
    enable = true;

    ca = "/etc/nebula/ca.crt";
    cert = "/etc/nebula/host.crt";
    key = "/etc/nebula/host.key";

    settings = {
      # https://github.com/slackhq/nebula/blob/master/examples/config.yml

      static_host_map = let thisHost = lighthouses.${hostName} or ""; in removeAttrs staticHosts [ thisHost ];

      lighthouse = rec {
        am_lighthouse = elem hostName lighthouseHostnames;
        interval = 60;
        hosts = mkIf (!am_lighthouse) lighthouseIps;
      };

      punchy = {
        punch = true;
        respond = true;
      };

      cipher = "aes";

      preferred_ranges = "192.168.0.0/24";

      tun = {
        disabled = false;
        dev = "nebula0";
        drop_local_broadcast = false;
        drop_multicast = false;
        tx_queue = 500;
        mtu = 1300;
      };

      firewall = {
        conntrack = {
          tcp_timeout = "12m";
          udp_timeout = "3m";
          default_timeout = "10m";
          max_connections = 100000;
        };
        outbound = [{ port = "any"; proto = "any"; host = "any"; }];
        inbound = [{ port = "any"; proto = "any"; host = "any"; }];
      };
    };
  };
}
