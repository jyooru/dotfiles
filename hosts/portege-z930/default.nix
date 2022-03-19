{ config, suites, ... }:
{
  imports = suites.server ++ [
    ./hardware-configuration.nix
    ./vaultwarden.nix
  ];

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

  networking.firewall.interfaces."enp0s25".allowedTCPPorts = [
    22
    8000
    44300
    (import ../../profiles/yggdrasil/ports.nix).${config.networking.hostName}
  ];
  services.nebula.networks."joel".listen.port = 4243;
}
