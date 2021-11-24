{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-r700-b";

  boot = {
    loader.grub = {
      enable = true;
      enableCryptodisk = true;
      device = "/dev/disk/by-id/wwn-0x5000cca5b7f2354f";
      version = 2;
    };
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/c7206449-23ca-4268-bfc5-23929d0422bc";
      preLVM = true;
      allowDiscards = true;
    };
  };

  services.nebula.networks."joel" = {
    listen.port = 4242;
    staticHostMap = {
      "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
      # "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
      "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
      "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
    };
    lighthouses = [
      "10.42.0.11"
      # "10.42.0.12"
      "10.42.0.13"
      "10.42.0.14"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 8384 ];
  services.syncthing = {
    guiAddress = "10.42.0.12:8384"; # TODO: only allow `thinkpad-e580`   
    declarative.devices = {
      "thinkpad-e580" = {
        addresses = [ "tcp://thinkpad-e580.dev.joel.tokyo:22000" ];
        id = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
      };
      "portege-r700-a" = {
        addresses = [ "tcp://portege-r700-a.dev.joel.tokyo:22000" ];
        id = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
      };
      # "portege-r700-b" = {
      #   addresses = [ "tcp://portege-r700-b.dev.joel.tokyo:22000" ];
      #   id = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
      # };
      "portege-z930" = {
        addresses = [ "tcp://portege-z930.dev.joel.tokyo:22000" ];
        id = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
      };
      "ga-z77-d3h" = {
        addresses = [ "tcp://ga-z77-d3h.dev.joel.tokyo:22000" ];
        id = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
      };
    };
    declarative.folders = {
      "cluster" = {
        label = "cluster";
        id = "jyxof-ssssq";
        path = "/home/joel/cluster";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "portege-r700-b"
          "portege-z930"
          "ga-z77-d3h"
        ];
      };
    };
  };
}
