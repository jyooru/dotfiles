{ config, pkgs, lib, ... }:
let
  cfg = config.modules.programs.rofi;
in
{
  options.modules.programs.rofi = {
    enable = lib.mkEnableOption "Launcher";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.joel.programs.rofi = {
      enable = true;
    };
  };
}
