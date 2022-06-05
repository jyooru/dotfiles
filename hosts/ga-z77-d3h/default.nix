{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./minecraft.nix

    ../../profiles/servers/hercules-ci

    ../../suites/server
  ];

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

  networking.firewall.interfaces."enp4s0".allowedTCPPorts = [
    22
    8000
    (import ../../profiles/nodes/ipfs/ports.nix).${config.networking.hostName}
    (import ../../profiles/networks/yggdrasil/ports.nix).${config.networking.hostName}
    44300
  ];
  services = {
    nebula.networks."joel".listen.port = 4244;

    nix-serve = {
      enable = true;
      secretKeyFile = "/var/binary-cache.pem";
    };
  };
  systemd.services.nix-serve.environment.HOME = "/dev/null";
}
