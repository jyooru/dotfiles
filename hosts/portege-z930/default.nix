{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-z930";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

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
}
