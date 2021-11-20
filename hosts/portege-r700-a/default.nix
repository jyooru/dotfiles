{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-r700-a";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

  modules = {
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/todo";
    };
  };
};
