{ pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk
  ];

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  services = {
    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      displayManager = {
        defaultSession = "none+qtile";
        autoLogin = { enable = true; user = "joel"; };
      };

      libinput.enable = true;

      windowManager.qtile.enable = true;
    };
  };
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.enable = true;
    steam.enable = true;
  };
}
