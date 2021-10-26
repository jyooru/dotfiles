{ config, pkgs, lib, ... }:
let
  cfg = config.modules.programs.betterlockscreen;
in
{
  options.modules.programs.betterlockscreen = {
    enable = lib.mkEnableOption "Lock screen";
  };
  config = lib.mkIf cfg.enable {
    home.file.betterlockscreenrc = {
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
