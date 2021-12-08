{ config, pkgs, ... }:
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

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.interfaces."docker0".allowedTCPPorts = [ 5000 8384 ];
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
    guiAddress = "0.0.0.0:8384";
    folders = {
      "archive" = {
        id = "u4tsv-7hxb7";
        path = "/home/joel/archive";
        # path = "/home/joel/files/archive";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "ga-z77-d3h"
        ];
      };
      "cluster" = {
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
      "code" = {
        id = "wcqyy-zrab5";
        path = "/home/joel/code";
        # path = "/home/joel/files/code";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "portege-r700-b"
          "portege-z930"
          "ga-z77-d3h"
        ];
      };
      "documents" = {
        id = "pgpew-tged2";
        path = "/home/joel/documents";
        # path = "/home/joel/files/documents";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "ga-z77-d3h"
        ];
      };
      "games" = {
        id = "xt4t4-d2jad";
        path = "/home/joel/games";
        # path = "/home/joel/files/games";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "ga-z77-d3h"
        ];
      };
      "media" = {
        id = "kasul-jsgfj";
        path = "/home/joel/media";
        # path = "/home/joel/files/media";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "ga-z77-d3h"
        ];
      };
      "notes" = {
        id = "bc6qz-tad4c";
        path = "/home/joel/school";
        # path = "/home/joel/files/notes";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "ga-z77-d3h"
        ];
      };
      "school" = {
        id = "s6jde-csrow";
        path = "/home/joel/school";
        # path = "/home/joel/files/school";
        devices = [
          # "thinkpad-e580"
          "portege-r700-a"
          "ga-z77-d3h"
        ];
      };
      "tmp" = {
        id = "5f6yn-csxu7";
        path = "/home/joel/tmp";
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
  home-manager.users.joel.home.file."nodeCaddyfile" = {
    target = "node/config/Caddyfile";
    text = ''
      {
        log {
          output file /var/log/caddy/log.json {
            roll_keep_for 14d
          }
        }
      }

      import secretsCaddyfile # cloudflare key for tls

      ${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        respond "Hello world"
      }

      nix.${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        reverse_proxy 172.17.0.1:5000
      }

      syncthing.srv.${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        reverse_proxy 172.17.0.1:8384
      }

      ipfs.srv.${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        respond "Hello world"
      }
    '';
  };
  virtualisation.oci-containers.containers = {
    "caddy" = {
      image = "jyooru/caddy";
      ports = [ "80:80" "443:443" ];
      volumes = [
        "/home/joel/node/config/Caddyfile:/etc/caddy/Caddyfile:ro"
        "/home/joel/node/config/secretsCaddyfile:/etc/caddy/secretsCaddyfile:ro"
        "/home/joel/node/data/caddy:/data"
        "/home/joel/node/log/caddy:/var/log/caddy"
      ];
    };
  };
}
