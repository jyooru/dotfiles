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
      enable = false; # TODO: multiple devices. setup below
      # device = "/dev/disk/by-uuid/646fc0f1-2d8a-4901-ae89-559154bfe288";
    };
    packages = {
      apps = false;
      code = false;
      desktopEnvironment = false;
      tools = true;
    };
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/646fc0f1-2d8a-4901-ae89-559154bfe288";
      preLVM = true;
      allowDiscards = true;
    };
    initrd.luks.devices.crypt2 = {
      device = "/dev/disk/by-uuid/88c631bb-5335-4989-8cc5-09c4f38c8fa7";
      preLVM = true;
      allowDiscards = true;
    };
  };
}
