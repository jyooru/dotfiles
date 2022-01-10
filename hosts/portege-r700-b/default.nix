{ suites, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "portege-r700-b";

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
  networking.firewall.allowedTCPPorts = [ 7174 7175 1885 ];
  virtualisation.oci-containers.containers."streamr".ports = [ "7174:7174" "7175:7175" "1885:1885" ];
}
