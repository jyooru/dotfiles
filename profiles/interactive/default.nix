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

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;

      displayManager = {
        defaultSession = "none+qtile";
        autoLogin = { enable = true; user = "joel"; };
      };
      windowManager.qtile.enable = true;

      libinput.enable = true;
    };
  };

  programs = {
    gnupg.agent.enable = true;
    nm-applet.enable = true;
    steam.enable = true;
  };
}
