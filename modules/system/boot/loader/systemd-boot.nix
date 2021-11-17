{ config, lib, ... }:

with lib;

let
  cfg = config.modules.system.boot.loader.systemd-boot;
in

{
  options.modules.system.boot.loader.systemd-boot = {
    enable = mkEnableOption "Boot loader";
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
