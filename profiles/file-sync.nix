{ config, lib, ... }:
let
  inherit (lib) elem mapAttrs filterAttrs remove;
  inherit (config.networking) domain hostName;

  all = cluster ++ [ "galaxy-a22" ];
  allBackup = backup ++ [ "galaxy-a22" ];
  backup = [ "thinkpad-e580" "portege-r700-a" "ga-z77-d3h" ]; # nodes in cluster with big hard drive plus laptop
  cluster = [ "thinkpad-e580" "portege-r700-a" "portege-r700-b" "portege-z930" "ga-z77-d3h" ]; # all nodes in cluster plus laptop
  devices = mapAttrs
    (name: id: { addresses = [ "tcp://${name}.${domain}:22000" ]; inherit id; })
    {
      "thinkpad-e580" = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
      "galaxy-a22" = "AWUGYY2-D3Y2JT7-VXU6T3I-SOYSY7T-PA3O4ST-QWE5MHL-6BWY6NJ-6RKXZAM";
      "portege-r700-a" = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
      "portege-r700-b" = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
      "portege-z930" = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
      "ga-z77-d3h" = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
    };
  specialDevices = remove "thinkpad-e580" cluster;

  folders = mapAttrs
    (name: values: values // { path = ''/home/joel${if (elem hostName specialDevices) && (!(elem name specialFolders)) then "/files" else ""}/'' + name; })
    {
      "archive" = { devices = allBackup; id = "u4tsv-7hxb7"; };
      "cluster" = { devices = cluster; id = "jyxof-ssssq"; };
      "code" = { devices = cluster; id = "wcqyy-zrab5"; };
      "data" = { devices = allBackup; id = "n3a2w-sqney"; };
      "documents" = { devices = allBackup; id = "pgpew-tged2"; };
      "games" = { devices = backup; id = "xt4t4-d2jad"; };
      "media" = { devices = backup; id = "kasul-jsgfj"; };
      "media/phone" = { devices = allBackup; id = "xkgdh-rrx6u"; };
      "notes" = { devices = allBackup; id = "bc6qz-tad4c"; };
      "school" = { devices = allBackup; id = "s6jde-csrow"; };
      "tmp" = { devices = all; id = "5f6yn-csxu7"; };
    };
  specialFolders = [ "cluster" "tmp" ]; # folders not in this list are put in ~/files on cluster nodes
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
    devices = removeAttrs devices [ hostName ];
    folders = mapAttrs (name: values: values // { devices = remove hostName values.devices; })
      (filterAttrs (_: v: elem hostName v.devices) folders);
  };
}
