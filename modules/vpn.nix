{ config, lib, ... }:

with lib;

let
  cfg = config.modules.vpn;
in

{
  options.modules.vpn = {
    enable = mkOption { default = false; type = types.bool; };
  };
  config = mkIf cfg.enable {
    services.nebula.networks."joel" = {
      enable = true;
      ca = "/etc/nebula/ca.crt";
      cert = "/etc/nebula/host.crt";
      key = "/etc/nebula/host.key";
      # set in each host, needs refactoring
      # staticHostMap = {
      #   "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
      #   "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
      #   "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
      #   "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
      # };
      # lighthouses = [
      #   "10.42.0.11"
      #   "10.42.0.12"
      #   "10.42.0.13"
      #   "10.42.0.14"
      # ];
      firewall = {
        outbound = [{ port = "any"; proto = "any"; host = "any"; }];
        inbound = [{ port = "any"; proto = "any"; host = "any"; }];
      };
      settings = {
        lighhouse.interval = 60;
        listen = { host = "[::]"; };
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

