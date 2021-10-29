{ config, pkgs, lib, ... }:
let
  cfg = config.modules.programs.alacritty;
in
{
  options.modules.programs.alacritty = {
    enable = lib.mkEnableOption "Terminal emulator";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.joel.programs.alacritty = {
      enable = true;
      settings = {
        # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
        env = {
          WINIT_X11_SCALE_FACTOR = "1"; # fix font size not changing
        };
        window = {
          padding = {
            x = 25;
            y = 25;
          };
          dynamic_padding = true;
        };
        font = {
          normal = { family = "FiraCode Nerd Font"; };
          size = 11;
        };
        colors = {
          primary = {
            background = "#1f1f1f";
            foreground = "#bbbbbb";
          };
          normal = {
            black = "#000000";
            red = "#cd3131";
            green = "#0dbc79";
            yellow = "#e5e510";
            blue = "#2472c8";
            magenta = "#bc3fbc";
            cyan = "#11a8cd";
            white = "#e5e5e5";
          };
          bright = {
            black = "#5c5c5c";
            red = "#f14c4c";
            green = "#23d18b";
            yellow = "#f5f543";
            blue = "#3b8eea";
            magenta = "#d670d6";
            cyan = "#29b8db";
            white = "#e5e5e5";
          };
        };
      };
    };
  };
}
