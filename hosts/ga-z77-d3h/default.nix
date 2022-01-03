{
  imports = [ ./hardware-configuration.nix ../../tmp-hosts-server.nix ];

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

  networking.firewall.allowedTCPPorts = [ 7170 7171 1883 25565 ];
  virtualisation.oci-containers.containers = {
    "minecraft" = {
      image = "itzg/minecraft-server";
      ports = [ "25565:25565" ];
      environment = {
        EULA = "true";
        TYPE = "purpur";
        OVERRIDE_SERVER_PROPERTIES = "true";
        MOTD = "\\u00A7b                    \\u00A7lplay.joel.tokyo\\u00A7r\\n\\u00A7c                          [1.18.1]";
        MEMORY = "4G";
        ENABLE_ROLLING_LOGS = "true";
        DIFFICULTY = "hard";
      };
      extraOptions = [ "--tty" ];
      volumes = [
        "/home/joel/node/data/minecraft:/data"
      ];
    };
  };
  virtualisation.oci-containers.containers."streamr".ports = [ "7170:7170" "7171:7171" "1883:1883" ];

  networking.firewall.interfaces."nebula0".allowedTCPPorts = [ 2201 ];
  containers."sftp" = {
    autoStart = true;

    bindMounts."files" = {
      hostPath = "/home/joel/files";
      mountPoint = "/srv";
      isReadOnly = false;
    };

    config = {
      services.openssh = {
        enable = true;
        listenAddresses = [{ addr = "0.0.0.0"; port = 2201; }];
        passwordAuthentication = false;
      };

      users.users.joel = {
        isNormalUser = true;
        openssh.authorizedKeys.keyFiles = [
          ../galaxy-a22/com.termux/id_rsa.pub
          ../galaxy-a22/me.zhanghai.android.files/id_rsa.pub
        ];
      };
    };

    ephemeral = true;
  };
}
