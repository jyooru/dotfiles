{ config, lib, ... }:
let
  serverPath = (if config.networking.hostName != "thinkpad-e580" then "files/" else "");

  allDevices = clusterDevices ++ [ "galaxy-a22" ];
  backupDevices = [ "thinkpad-e580" "portege-r700-a" "ga-z77-d3h" ];
  clusterDevices = [ "thinkpad-e580" "portege-r700-a" "portege-r700-b" "portege-z930" "ga-z77-d3h" ];
in
{
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "204800";
  };

  services.syncthing = {
    user = "joel";
    group = "users";
    configDir = "/home/joel/.config/syncthing";
    dataDir = "/home/joel";
    openDefaultPorts = true;
    systemService = true;
    devices = (removeAttrs
      (builtins.mapAttrs
        (name: id: {
          addresses = [ "tcp://${name}.${config.networking.domain}:22000" ];
          inherit id;
        })
        {
          "thinkpad-e580" = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
          "galaxy-a22" = "AWUGYY2-D3Y2JT7-VXU6T3I-SOYSY7T-PA3O4ST-QWE5MHL-6BWY6NJ-6RKXZAM";
          "portege-r700-a" = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
          "portege-r700-b" = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
          "portege-z930" = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
          "ga-z77-d3h" = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
        }) [ config.networking.hostName ]);
    folders = builtins.mapAttrs
      (name: value: removeAttrs
        (value // {
          devices = lib.remove config.networking.hostName value.devices;
          path = "/home/joel/${if value.serverAltPath or false then serverPath else ''''}${name}";
        }) [ "serverAltPath" ])
      (lib.filterAttrs (_: value: builtins.any (x: x == config.networking.hostName) value.devices) {
        "archive" = { id = "u4tsv-7hxb7"; devices = backupDevices; serverAltPath = true; };
        "cluster" = { id = "jyxof-ssssq"; devices = clusterDevices; };
        "code" = { id = "wcqyy-zrab5"; devices = clusterDevices; serverAltPath = true; };
        "documents" = { id = "pgpew-tged2"; devices = backupDevices; serverAltPath = true; };
        "games" = { id = "xt4t4-d2jad"; devices = backupDevices; serverAltPath = true; };
        "media" = { id = "kasul-jsgfj"; devices = backupDevices; serverAltPath = true; };
        "media/phone" = { id = "xkgdh-rrx6u"; devices = backupDevices ++ [ "galaxy-a22" ]; serverAltPath = true; };
        "notes" = { id = "bc6qz-tad4c"; devices = backupDevices ++ [ "galaxy-a22" ]; serverAltPath = true; };
        "school" = { id = "s6jde-csrow"; devices = backupDevices; serverAltPath = true; };
        "tmp" = { id = "5f6yn-csxu7"; devices = allDevices; };
      });
  };
}
