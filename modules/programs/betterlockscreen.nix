{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.betterlockscreen;
in

{
  options.modules.programs.betterlockscreen = {
    enable = mkEnableOption "Lock screen";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ betterlockscreen ];

    home-manager.users.joel.home.file.betterlockscreenrc = {
      target = ".config/betterlockscreenrc";
      text = ''
        font="FiraCode Nerd Font"
        timecolor=e5e5e5ff
        time_format="%I:%M"
        locktext="    locked"
        
        ringcolor=5c5c5cff
        insidecolor=00000000
        ringvercolor=5c5c5cff
        insidevercolor=5c5c5cff
        ringwrongcolor=5c5c5cff
        insidewrongcolor=cd3131ff
        keyhlcolor=e5e5e5ff
        bshlcolor=e5e5e5ff
      '';
    };
  };
}
