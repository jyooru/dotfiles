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
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/binary-cache.pem";
  };
  services.syncthing = {
    enable = true;
    devices = {
      # "thinkpad-e580" = {
      #   addresses = [ "tcp://thinkpad-e580.dev.joel.tokyo:22000" ];
      #   id = "XBWJHAC-FE2X3L2-MSS5ID4-JVE3VOV-HKWEAD3-4V6QRGC-JUKFOKR-5JDOVAE";
      # };
      "portege-r700-a" = {
        addresses = [ "tcp://portege-r700-a.dev.joel.tokyo:22000" ];
        id = "O4R7UYN-CQPXSCH-NOCFRNH-6KW63ZX-GXXZQR2-M5L44FP-7WN5CV5-JSRBHQ4";
      };
      "portege-r700-b" = {
        addresses = [ "tcp://portege-r700-b.dev.joel.tokyo:22000" ];
        id = "ZYK4DWO-APF4R5A-XBDBGXV-FO46RGA-XPGZPJK-VGCC57W-DIJ6DWP-4YMACQL";
      };
      "portege-z930" = {
        addresses = [ "tcp://portege-z930.dev.joel.tokyo:22000" ];
        id = "JOYBHZH-W4IQAET-WVLQT2J-FUYKMAR-XFJCXKA-D3KQFWC-XE3DNDU-3VJ33QZ";
      };
      "ga-z77-d3h" = {
        addresses = [ "tcp://ga-z77-d3h.dev.joel.tokyo:22000" ];
        id = "QMOXUMI-JSL766T-CUTKFMC-TUUG3MC-FYWAGI7-4DRVYYC-KU6TDPS-QPBGEAV";
      };
    };
    folders = {
      "cluster" = {
        label = "cluster";
        id = "jyxof-ssssq";
        path = "/home/joel/cluster";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          "portege-z930"
          "ga-z77-d3h"
        ];
      };
    };
  };
}
