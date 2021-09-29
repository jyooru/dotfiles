{ config, pkgs, ... }:

{
  programs = {
    alacritty = { enable = true; };
    rofi = { enable = true; };
  };

  services = {
    polybar = {
      enable = true;
      script = "polybar bar &";
    };
  };

}
