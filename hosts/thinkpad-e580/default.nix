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
    hardware = {
      iphone = {
        enable = true;
        user = "joel";
      };
    };
    programs = {
      alacritty.enable = true;
      bash.enable = true;
      betterlockscreen.enable = true;
      git.enable = true;
      rofi.enable = true;
      starship.enable = true;
      vscode.enable = true;
    };
    services = {
      networking.nebula.enable = true;
      x11.window-manager.bspwm.enable = true;
    };
  };
}

