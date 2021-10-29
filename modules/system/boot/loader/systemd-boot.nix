{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.system.boot.loader.systemd-boot;
in
{
  options.modules.system.boot.loader.systemd-boot = {
    enable = lib.mkEnableOption "Boot loader";
    device = lib.mkOption { type = types.str; };
  };
  config = lib.mkIf cfg.enable {
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
