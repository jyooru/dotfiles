{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "ga-z77-d3h";

  modules = {
    system.boot.loader.systemd-boot = {
      enable = false; # TODO: multiple devices. setup below
      # device = "/dev/disk/by-uuid/646fc0f1-2d8a-4901-ae89-559154bfe288";
    };
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/646fc0f1-2d8a-4901-ae89-559154bfe288";
      preLVM = true;
      allowDiscards = true;
    };
    initrd.luks.devices.crypt2 = {
      device = "/dev/disk/by-uuid/88c631bb-5335-4989-8cc5-09c4f38c8fa7";
      preLVM = true;
      allowDiscards = true;
    };
  };

  services.nebula.networks."joel" = {
    listen.port = 4244;
    staticHostMap = {
      "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
      "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
      "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
      # "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
    };
    lighthouses = [
      "10.42.0.11"
      "10.42.0.12"
      "10.42.0.13"
      # "10.42.0.14"
    ];
  };


  networking.firewall.allowedTCPPorts = [ 25565 ];

  virtualisation.oci-containers.containers = {
    "minecraft-server" = {
      image = "itzg/minecraft-server";
      ports = [ "25565:25565" ];
      environment = {
        EULA = "true";
        TYPE = "purpur";
        OVERRIDE_SERVER_PROPERTIES = "true";
        MOTD = "\\u00A7b                    \\u00A7lplay.joel.tokyo\\u00A7r\\n\\u00A7c                          [1.17.1]";
        MEMORY = "4G";
        ENABLE_ROLLING_LOGS = "true";
      };
      extraOptions = [ "--tty" ];
      volumes = [
        "/home/joel/minecraft-server:/data"
      ];
    };
  };
  services.syncthing = {
    devices = {
      "thinkpad-e580" = {
        addresses = [ "tcp://thinkpad-e580.dev.joel.tokyo:22000" ];
        id = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
      };
      "portege-r700-a" = {
        addresses = [ "tcp://portege-r700-a.dev.joel.tokyo:22000" ];
        id = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
      };
      "portege-r700-b" = {
        addresses = [ "tcp://portege-r700-b.dev.joel.tokyo:22000" ];
        id = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
      };
      "portege-z930" = {
        addresses = [ "tcp://portege-z930.dev.joel.tokyo:22000" ];
        id = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
      };
      # "ga-z77-d3h" = {
      #   addresses = [ "tcp://ga-z77-d3h.dev.joel.tokyo:22000" ];
      #   id = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
      # };
    };
    folders = {
      "archive" = {
        id = "u4tsv-7hxb7";
        # path = "/home/joel/archive";
        path = "/home/joel/files/archive";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "ga-z77-d3h"
        ];
      };
      "cluster" = {
        id = "jyxof-ssssq";
        path = "/home/joel/cluster";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          "portege-z930"
          # "ga-z77-d3h"
        ];
      };
      "code" = {
        id = "wcqyy-zrab5";
        # path = "/home/joel/code";
        path = "/home/joel/files/code";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          "portege-z930"
          # "ga-z77-d3h"
        ];
      };
      "documents" = {
        id = "pgpew-tged2";
        # path = "/home/joel/documents";
        path = "/home/joel/files/documents";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "ga-z77-d3h"
        ];
      };
      "games" = {
        id = "xt4t4-d2jad";
        # path = "/home/joel/games";
        path = "/home/joel/files/games";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "ga-z77-d3h"
        ];
      };
      "media" = {
        id = "kasul-jsgfj";
        # path = "/home/joel/media";
        path = "/home/joel/files/media";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "ga-z77-d3h"
        ];
      };
      "notes" = {
        id = "bc6qz-tad4c";
        # path = "/home/joel/school";
        path = "/home/joel/files/notes";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "ga-z77-d3h"
        ];
      };
      "school" = {
        id = "s6jde-csrow";
        # path = "/home/joel/school";
        path = "/home/joel/files/school";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          # "ga-z77-d3h"
        ];
      };
      "tmp" = {
        id = "5f6yn-csxu7";
        path = "/home/joel/tmp";
        devices = [
          "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          "portege-z930"
          # "ga-z77-d3h"
        ];
      };
    };
  };
}
