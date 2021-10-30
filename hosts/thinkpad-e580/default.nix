{
  imports = [ ./hardware-configuration.nix ../../configuration.nix ];

  networking.hostName = "thinkpad-e580";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../iphone-7/id_rsa.pub ];
  boot.binfmt.emulatedSystems = [ "armv6l-linux" ];

  modules = {
    hardware = {
      video = {
        amdgpu.enable = true;
      };
      iphone = {
        enable = true;
        user = "joel";
      };
    };
    programs = {
      alacritty.enable = true;
      bash.enable = true;
      betterlockscreen.enable = true;
      git.enable = true;
      rofi.enable = true;
      starship.enable = true;
      vscode.enable = true;
    };
    services = {
      networking.nebula.enable = true;
      x11.window-manager.bspwm.enable = true;
    };
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/a207fe6b-d073-459b-b381-b6bc0b3f00ba";
    };
  };
}

