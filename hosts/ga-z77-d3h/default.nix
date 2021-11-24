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


  networking.firewall.allowedTCPPorts = [ 25565 8384 ];

  virtualisation.oci-containers.containers = {
    "minecraft-server" = {
      image = "itzg/minecraft-server";
      ports = [ "25565:25565" ];
      environment = {
        EULA = "true";
        TYPE = "purpur";
        OVERRIDE_SERVER_PROPERTIES = "true";
        MOTD = "§b                   §lplay.joel.tokyo§r\n§c                          [1.17.1]";
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
    guiAddress = "10.42.0.14:8384"; # TODO: only allow `thinkpad-e580`  
    declarative.devices = {
      "thinkpad-e580" = {
        addresses = [ "tcp://thinkpad-e580.dev.joel.tokyo:22000" ];
        id = "ZGZKIBO-INVCFJZ-FNJLI4U-DCTPSAK-4E6HEDN-MN7N7VU-MFYGAKQ-OJK3LQI";
      };
      "portege-r700-a" = {
        addresses = [ "tcp://portege-r700-a.dev.joel.tokyo:22000" ];
        id = "XO6DZJC-7RSM4LX-6AUIPP7-5R6EKT6-V6H5IUJ-V727VCH-3MNBQN2-VHORMQT";
      };
      "portege-r700-b" = {
        addresses = [ "tcp://portege-r700-b.dev.joel.tokyo:22000" ];
        id = "DKUIHLH-W7RAGVR-P6S3UX3-APQ45J5-WJLXV3V-ZXD6AZW-UDCTIVE-NVL6OAH";
      };
      "portege-z930" = {
        addresses = [ "tcp://portege-z930.dev.joel.tokyo:22000" ];
        id = "EMAGNET-NP6GS7A-J2SNJRS-F2CHEVM-N66IDOL-5NQSEON-T4IILKA-O7JYRQF";
      };
      # "ga-z77-d3h" = {
      #   addresses = [ "tcp://ga-z77-d3h.dev.joel.tokyo:22000" ];
      #   id = "M4WECKC-ILOF44U-EKSAYGG-5OGRQST-DK3BXLV-4X3QQ7T-2T7SSAN-5V22DQH";
      # };
    };
  };
}
