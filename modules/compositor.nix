{ config, lib, ... }:

with lib;

let
  cfg = config.modules.compositor;
in

{
  options.modules.compositor = {
    enable = mkEnableOption "Compositor";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.services.picom = {
      enable = true;
      fade = true;
      noDNDShadow = false;
      noDockShadow = false;
      fadeSteps = [ "0.15" "0.15" ];
      shadow = true;
      shadowOpacity = "0.25";
      vSync = true;
    };
  };
}
