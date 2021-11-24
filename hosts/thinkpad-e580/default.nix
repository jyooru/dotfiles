{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "thinkpad-e580";

  users.users.joel.openssh.authorizedKeys.keyFiles = [ ../iphone-7/id_rsa.root.pub ];

  modules = {
    config = {
      distributedBuild.enable = true;
    };
    hardware = {
      android = { enable = true; supportSamsung = true; };
      video = {
        amdgpu.enable = true;
      };
      iphone = { enable = true; user = "joel"; };
    };
    programs = {
      alacritty.enable = true;
      bash.enable = true;
      betterlockscreen.enable = true;
      git.enable = true;
      ranger.enable = true;
      rofi.enable = true;
      starship.enable = true;
      vscode.enable = true;
    };
    services = {
      polybar.enable = true;
      networking.nebula.enable = true;
      x11.window-manager.bspwm.enable = true;
    };
    system.boot.loader.systemd-boot = {
      enable = true;
      device = "/dev/disk/by-uuid/a207fe6b-d073-459b-b381-b6bc0b3f00ba";
    };
    packages = {
      apps = true;
      code = true;
      desktopEnvironment = true;
      tools = true;
    };
  };

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  i18n.defaultLocale = "en_AU.UTF-8";

  services = {
    auto-cpufreq.enable = true;

    xserver = {
      enable = true;

      desktopManager = { xterm.enable = false; };
      displayManager = { defaultSession = "none+bspwm"; };
      windowManager.bspwm = { enable = true; };

      libinput.enable = true; # touchpad
      layout = "au";
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

  home-manager.users.joel = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "\$HOME/desktop";
      documents = "\$HOME/documents";
      download = "\$HOME/downloads";
      music = "\$HOME/media/music";
      pictures = "\$HOME/media/screenshots";
      publicShare = "\$HOME/share";
      templates = "\$HOME/templates";
      videos = "\$HOME/media/videos";
    };
  };

  services.nebula.networks."joel" = {
    staticHostMap = {
      "10.42.0.11" = [ "home.run.joel.tokyo:4241" "192.168.0.11:4241" ];
      "10.42.0.12" = [ "home.run.joel.tokyo:4242" "192.168.0.12:4242" ];
      "10.42.0.13" = [ "home.run.joel.tokyo:4243" "192.168.0.13:4243" ];
      "10.42.0.14" = [ "home.run.joel.tokyo:4244" "192.168.0.14:4244" ];
    };
    lighthouses = [
      "10.42.0.11"
      "10.42.0.12"
      "10.42.0.13"
      "10.42.0.14"
    ];
  };
  services.syncthing = {
    enable = true;
    declarative.devices = {
      # "thinkpad-e580" = {
      #   addresses = [ "tcp://thinkpad-e580.dev.joel.tokyo:22000" ];
      #   id = "ZGZKIBO-INVCFJZ-FNJLI4U-DCTPSAK-4E6HEDN-MN7N7VU-MFYGAKQ-OJK3LQI";
      # };
      "portege-r700-a" = {
        addresses = [ "tcp://portege-r700-a.dev.joel.tokyo:22000" ];
        id = "XO6DZJC-7RSM4LX-6AUIPP7-5R6EKT6-V6H5IUJ-V727VCH-3MNBQN2-VHORMQT";
      };
      "portege-r700-b" = {
        addresses = [ "tcp://portege-r700-b.dev.joel.tokyo:22000" ];
        id = "DKUIHLH-W7RAGVR-P6S3UX3-APQ45J5-WJLXV3V-ZXD6AZW-UDCTIVE-NVL6OAH";
      };
      "portege-z930" = {
        addresses = [ "tcp://portege-z930.dev.joel.tokyo:22000" ];
        id = "EMAGNET-NP6GS7A-J2SNJRS-F2CHEVM-N66IDOL-5NQSEON-T4IILKA-O7JYRQF";
      };
      "ga-z77-d3h" = {
        addresses = [ "tcp://ga-z77-d3h.dev.joel.tokyo:22000" ];
        id = "M4WECKC-ILOF44U-EKSAYGG-5OGRQST-DK3BXLV-4X3QQ7T-2T7SSAN-5V22DQH";
      };
    };
  };
}
