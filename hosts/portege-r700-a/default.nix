{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-r700-a";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

  modules = {
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/1e0a9818-455d-412a-aad3-36ed4f85c741";
    };
  };
};
