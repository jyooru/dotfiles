{
  imports = [ ./hardware-configuration.nix ];

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

  services.nebula.networks."joel".listen.port = 4241;
  networking.firewall.allowedTCPPorts = [ 7172 7173 1884 ];
  virtualisation.oci-containers.containers."streamr".ports = [ "7172:7172" "7173:7173" "1884:1884" ];
}
