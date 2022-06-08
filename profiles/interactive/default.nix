{ pkgs, lib, ... }:

with lib;

{
  fonts = {
    fontconfig.defaultFonts = genAttrs [ "monospace" "serif" "sansSerif" ] (_: [ "FiraCode Nerd Font" ]);
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
    ];
  };

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    displayManager = {
      defaultSession = "none+qtile";
      autoLogin = { enable = true; user = "joel"; };
    };
    windowManager.qtile.enable = true;

    libinput.enable = true;
  };

  programs = {
    gnupg.agent.enable = true;
    nm-applet.enable = true;
    steam.enable = true;
  };
}
