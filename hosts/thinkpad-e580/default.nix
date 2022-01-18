{ config, pkgs, suites, ... }:
{
  imports = [ ./hardware-configuration.nix ] ++ suites.base;

  networking.hostName = "thinkpad-e580";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.cryptvg = {
      device = "/dev/disk/by-uuid/a207fe6b-d073-459b-b381-b6bc0b3f00ba";
      preLVM = true;
      allowDiscards = true;
    };
  };

  users.users = {
    root.openssh.authorizedKeys.keyFiles = [ ./id_rsa.root.pub ]; # deploy
    joel.openssh.authorizedKeys.keyFiles = [
      ../galaxy-a22/com.termux/id_rsa.pub
      ../galaxy-a22/me.zhanghai.android.files/id_rsa.pub
    ];
  };

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  services = {
    auto-cpufreq.enable = true;

    xserver = {
      enable = true;

      # something automatically generates this. adding nixos-hardware.nixosModules.common-gpu-amd overrides this for some reason. this fixes this
      videoDrivers = [ "amdgpu" "radeon" "nouveau" "modesetting" "fbdev" ];

      desktopManager.xterm.enable = false;
      displayManager = {
        defaultSession = "none+qtile";
        autoLogin = { enable = true; user = "joel"; };
      };

      windowManager.qtile.enable = true;

      libinput.enable = true; # touchpad
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

  # this host isn't a lighthouse, but all hosts should have a unique port for NAT traversal to avoid overlaps
  services.nebula.networks."joel".listen.port = 4240;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.interfaces."docker0".allowedTCPPorts = [ 5000 8384 ];
  networking.firewall.interfaces."nebula0".allowedTCPPorts = [ 8080 ]; # tmp.joel.tokyo
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/binary-cache.pem";
  };
  systemd.services.nix-serve.environment.HOME = "/dev/null";
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
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
