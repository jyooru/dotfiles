{ config, lib, pkgs, options, ... }:

with lib;

let
  cfg = config.networking.firewall.lan;
in

{
  options.networking.firewall.lan = {
    interfaces = mkOption {
      default = [ ];
      type = types.listOf types.str;
    };

    inherit (options.networking.firewall)
      allowedTCPPorts allowedTCPPortRanges
      allowedUDPPorts allowedUDPPortRanges;
  };

  config = mkIf (cfg.interfaces != [ ]) {
    networking.firewall.interfaces = genAttrs cfg.interfaces (_: {
      inherit (cfg)
        allowedTCPPorts allowedTCPPortRanges
        allowedUDPPorts allowedUDPPortRanges;
    });
  };
}
