{ suites, ... }:
{
  imports = suites.server ++ [
    ./hardware-configuration.nix
  ];

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

  services.nebula.networks."joel".listen.port = 4242;
}
