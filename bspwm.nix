{ config, pkgs, ... }:

{
  programs = {
    alacritty = { enable = true; };
    rofi = { enable = true; };
  };

  services = { polybar = { enable = true; }; };

  xsession.windowManager.bspwm = { enable = true; };
}
