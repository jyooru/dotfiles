{ config, lib, ... }:

with lib;

let
  cfg = config.modules.launcher;
in

{
  options.modules.launcher = {
    enable = mkEnableOption "Launcher";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.rofi = {
      enable = true;
    };
  };
}
