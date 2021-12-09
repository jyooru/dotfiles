{ config, lib, ... }:
let
  serverPath = (if config.networking.hostName != "thinkpad-e580" then "files/" else "");
  backupDevices = [ "thinkpad-e580" "portege-r700-a" "ga-z77-d3h" ];
  clusterDevices = [ "thinkpad-e580" "portege-r700-a" "portege-r700-b" "portege-z930" "ga-z77-d3h" ];
in
{
  services.syncthing = {
    devices = (removeAttrs
      (builtins.mapAttrs
        (name: id: {
          addresses = [ "tcp://${name}.${config.networking.domain}:22000" ];
          inherit id;
        })
        {
          "thinkpad-e580" = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
          "portege-r700-a" = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
          "portege-r700-b" = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
          "portege-z930" = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
          "ga-z77-d3h" = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
        }) [ config.networking.hostName ]);
    folders = builtins.mapAttrs
      (_: value: value // {
        devices = lib.remove config.networking.hostName value.devices;
      })
      (lib.filterAttrs (_: value: builtins.any (x: x == config.networking.hostName) value.devices) {
        "archive" = {
          id = "u4tsv-7hxb7";
          path = "/home/joel/${serverPath}archive";
          devices = backupDevices;
        };
        "cluster" = {
          id = "jyxof-ssssq";
          path = "/home/joel/cluster";
          devices = clusterDevices;
        };
        "code" = {
          id = "wcqyy-zrab5";
          path = "/home/joel/${serverPath}code";
          devices = clusterDevices;
        };
        "documents" = {
          id = "pgpew-tged2";
          path = "/home/joel/${serverPath}documents";
          devices = backupDevices;
        };
        "games" = {
          id = "xt4t4-d2jad";
          path = "/home/joel/${serverPath}games";
          devices = backupDevices;
        };
        "media" = {
          id = "kasul-jsgfj";
          path = "/home/joel/${serverPath}media";
          devices = backupDevices;
        };
        "notes" = {
          id = "bc6qz-tad4c";
          path = "/home/joel/${serverPath}school";
          devices = backupDevices;
        };
        "school" = {
          id = "s6jde-csrow";
          path = "/home/joel/${serverPath}school";
          devices = backupDevices;
        };
        "tmp" = {
          id = "5f6yn-csxu7";
          path = "/home/joel/tmp";
          devices = clusterDevices;
        };
      });
  };
}


