{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-r700-b";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

  modules = {
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/044adac8-2b89-4a21-a702-ae4cee1ea2a4";
    };
  };
}
