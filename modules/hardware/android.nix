{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hardware.android;
in

{
  options.modules.hardware.android = {
    enable = mkEnableOption "Tools for working with Android devices";
    supportSamsung = mkEnableOption "Tools for working with Samsung Android devices";
  };
  config = mkIf cfg.enable {
    programs.adb.enable = true;
    environment.systemPackages = with pkgs; [
      scrcpy # android screen mirroring tool
    ] ++ lib.optional cfg.supportSamsung heimdall; # samsung device custom recovery installer
  };
}
