{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-z930";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

  modules = {
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/6669374d-350c-4512-96dd-66da3e8cffea";
    };
  };
}
