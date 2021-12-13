{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "ga-z77-d3h";

  modules = {
    bootloader = {
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

  services.nebula.networks."joel".listen.port = 4244;

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
        VERSION = "1.17.1";
      };
      extraOptions = [ "--tty" ];
      volumes = [
        "/home/joel/minecraft-server:/data"
      ];
    };
  };
}
