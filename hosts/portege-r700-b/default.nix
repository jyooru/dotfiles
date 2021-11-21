{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-r700-b";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

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

  services.nebula.networks."joel" = {
    staticHostMap = {
      "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
      # "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
      "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
      "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
    };
    lighthouses = [
      "10.42.0.11"
      # "10.42.0.12"
      "10.42.0.13"
      "10.42.0.14"
    ];
  };
}
