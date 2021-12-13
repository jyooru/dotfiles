{ config, lib, ... }:

with lib;

let
  cfg = config.modules.bootloader;
in

{
  options.modules.bootloader = {
    enable = mkEnableOption "Bootloader";
    device = mkOption { type = types.str; };
  };
  config = mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      loader.efi.efiSysMountPoint = "/boot/efi";
      initrd.luks.devices.cryptvg = {
        device = cfg.device;
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
