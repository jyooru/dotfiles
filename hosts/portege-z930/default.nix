{
  imports = [ ./hardware-configuration.nix ../server.nix ];

  networking.hostName = "portege-z930";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/6669374d-350c-4512-96dd-66da3e8cffea";
      preLVM = true;
      allowDiscards = true;
    };
  };
}
