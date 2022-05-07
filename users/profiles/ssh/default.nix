{ lib, ... }:

with lib;

{
  programs.ssh = {
    enable = true;
    matchBlocks =
      let
        hosts = {
          "l" = "thinkpad-e580";
          "1" = "portege-r700-a";
          "2" = "portege-r700-b";
          "3" = "portege-z930";
          "4" = "ga-z77-d3h";
        };
      in
      (mapAttrs (_: hostname: { inherit hostname; }) hosts) //
      (mapAttrs'
        (name: hostname: {
          name = "${name}y";
          value = { hostname = "${hostname}.joel.ygg"; };
        })
        hosts) //
      {
        "0 pi" = {
          hostname = "raspberrypi.local";
          user = "pi";
        };
        "r retropie" = {
          hostname = "192.168.0.21";
          user = "pi";
        };
      };
  };
}
