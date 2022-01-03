{
  imports = [ ./hardware-configuration.nix ../../tmp-hosts-server.nix ];

  networking.hostName = "portege-z930";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/79fff45f-671c-45e4-8eb0-d9f3d855942a";
      preLVM = true;
      allowDiscards = true;
    };
  };

  services.nebula.networks."joel".listen.port = 4243;

  networking.firewall.interfaces."docker0".allowedTCPPorts = [ 8002 ];

  virtualisation.oci-containers.containers = {
    "vaultwarden" = {
      image = "vaultwarden/server";
      ports = [ "8002:80" ];
      environment = {
        DOMAIN = "https://vaultwarden.srv.joel.tokyo";
        SIGNUPS_ALLOWED = "false";
        WEBSOCKET_ENABLED = "true";
      };
      volumes = [
        "/home/joel/node/data/vaultwarden:/data"
      ];
    };
  };
}
