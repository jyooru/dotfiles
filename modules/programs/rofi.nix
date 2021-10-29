{ config, lib, ... }:

with lib;

let
  cfg = config.modules.programs.rofi;
in

{
  options.modules.programs.rofi = {
    enable = mkEnableOption "Launcher";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.rofi = {
      enable = true;
    };
  };
}
