{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";

    initrd.luks.devices.cryptvg = {
      device = "/dev/disk/by-uuid/a207fe6b-d073-459b-b381-b6bc0b3f00ba";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.hostName = "thinkpad-e580";

  modules = {
    iphone = {
      enable = true;
      user = "joel";
    };
  };
}

