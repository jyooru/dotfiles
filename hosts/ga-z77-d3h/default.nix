{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "ga-z77-d3h";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../thinkpad-e580/id_rsa.pub ];

  modules = {
    config = {
      distributedBuild.enable = false; # TODO
    };
    hardware = {
      android = { enable = false; supportSamsung = false; };
      video = {
        amdgpu.enable = false;
      };
      iphone = { enable = false; user = "joel"; };
    };
    programs = {
      alacritty.enable = false;
      bash.enable = true;
      betterlockscreen.enable = false;
      git.enable = true;
      ranger.enable = true;
      rofi.enable = false;
      starship.enable = true;
      vscode.enable = false;
    };
    services = {
      polybar.enable = false;
      networking.nebula.enable = false; # TODO
      x11.window-manager.bspwm.enable = false;
    };
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/646fc0f1-2d8a-4901-ae89-559154bfe288";
    };
    packages = {
      apps = false;
      code = false;
      desktopEnvironment = false;
      tools = true;
    };
  };
}
