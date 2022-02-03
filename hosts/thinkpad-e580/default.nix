{ config, inputs, pkgs, profiles, suites, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ (with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-amd
    common-pc-laptop
    common-pc-laptop-ssd
  ]) ++ (with profiles; [
    distributed-build
    hardware.android
  ]) ++ suites.base;

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
    root.openssh.authorizedKeys.keyFiles = [ ./keys/ssh-root.pub ]; # deploy
    joel.openssh.authorizedKeys.keyFiles = [
      ../galaxy-a22/keys/ssh-com.termux.pub
      ../galaxy-a22/keys/ssh-me.zhanghai.android.files.pub
    ];
  };

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

  hardware.pulseaudio.enable = true;
  sound.enable = true;

  services = {
    auto-cpufreq.enable = true;

    # this host isn't a lighthouse, but all hosts should have a unique port for NAT traversal to avoid overlaps
    nebula.networks."joel".listen.port = 4240;

    nix-serve = {
      enable = true;
      secretKeyFile = "/var/binary-cache.pem";
    };

    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
    };

    xserver = {
      enable = true;

      desktopManager.xterm.enable = false;
      displayManager = {
        defaultSession = "none+qtile";
        autoLogin = { enable = true; user = "joel"; };
      };

      libinput.enable = true;

      windowManager.qtile.enable = true;

      # something automatically generates this - adding nixos-hardware.nixosModules.common-gpu-amd overrides it
      # so also add the automatically generated stuff so X works
      videoDrivers = [ "amdgpu" "radeon" "nouveau" "modesetting" "fbdev" ];
    };
  };
  systemd.services.nix-serve.environment.HOME = "/dev/null"; # bug fix

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.enable = true;
    steam.enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    interfaces = {
      "docker0".allowedTCPPorts = [ 5000 8384 ];
      "nebula0".allowedTCPPorts = [ 8080 ]; # tmp.joel.tokyo
    };
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

    home.file."nodeCaddyfile" = {
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
  };

  virtualisation = {
    oci-containers.containers."caddy" = {
      image = "jyooru/caddy";
      ports = [ "80:80" "443:443" ];
      volumes = [
        "/home/joel/node/config/Caddyfile:/etc/caddy/Caddyfile:ro"
        "/home/joel/node/config/secretsCaddyfile:/etc/caddy/secretsCaddyfile:ro"
        "/home/joel/node/data/caddy:/data"
        "/home/joel/node/log/caddy:/var/log/caddy"
      ];
    };

    virtualbox.host.enable = true;
  };
}
