{ config, suites, ... }:
{
  imports = suites.server ++ [
    ./hardware-configuration.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      enableCryptodisk = true;
      device = "/dev/disk/by-id/wwn-0x5000cca5f6c52022";
      version = 2;
    };
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/37e514fd-92d1-4f34-9a8f-ee32f083386c";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.firewall.interfaces."enp0s25".allowedTCPPorts = [
    22
    8000
    (import ../../profiles/ipfs/ports.nix).${config.networking.hostName}
    (import ../../profiles/yggdrasil/ports.nix).${config.networking.hostName}
    44300
  ];
  services.nebula.networks."joel".listen.port = 4241;
}
