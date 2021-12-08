{ config, ... }:
let
  # my config, TODO: move
  devices = {
    "thinkpad-e580" = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
    "portege-r700-a" = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
    "portege-r700-b" = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
    "portege-z930" = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
    "ga-z77-d3h" = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
  };

  removeStr = (str: list: builtins.filter (x: x != str) list);
  generateDevices = (devices: builtins.mapAttrs
    (name: value: {
      addresses = [ "tcp://${name}.${config.networking.domain}:22000" ];
      id = value;
    })
    devices);
in
{
  services.syncthing.devices = removeAttrs (generateDevices devices) [ config.networking.hostName ];
}
