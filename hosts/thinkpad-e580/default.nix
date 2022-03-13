{ config, inputs, pkgs, profiles, secrets, suites, ... }:
{
  imports = suites.base ++ (with profiles; [
    distributed-build
    hardware.android
    interactive
    yggdrasil
    ./hardware-configuration.nix
  ]) ++ (with inputs.hardware.nixosModules; [
    common-cpu-intel
    common-gpu-amd
    common-pc-laptop
    common-pc-laptop-ssd
  ]);

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



  services = {
    # this host isn't a lighthouse, but all hosts should have a unique port for NAT traversal to avoid overlaps
    nebula.networks."joel".listen.port = 4240;

    tlp.enable = true;

    # something automatically generates this - adding nixos-hardware.nixosModules.common-gpu-amd overrides it
    # so also add the automatically generated stuff so X works
    xserver.videoDrivers = [ "amdgpu" "radeon" "nouveau" "modesetting" "fbdev" ];
  };

  networking.firewall.interfaces = {
    "docker0".allowedTCPPorts = [ 5000 8384 ];
    "nebula0".allowedTCPPorts = [ 80 443 8080 ];
  };

  home-manager.users.joel.xdg.userDirs = {
    enable = true;
    desktop = "$HOME/desktop";
    documents = "$HOME/documents";
    download = "$HOME/downloads";
    music = "$HOME/media/music";
    pictures = "$HOME/media/screenshots";
    publicShare = "$HOME/share";
    templates = "$HOME/templates";
    videos = "$HOME/media/videos";
  };

  age.secrets."tls-joel.tokyo" = {
    file = secrets."tls-joel.tokyo";
    owner = "caddy";
    group = "caddy";
  };


  systemd.services.caddy.serviceConfig.AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
  services.caddy = {
    enable = true;
    package = pkgs.caddy-modded;
    extraConfig = with config.networking; ''
      (joel.tokyo) {
        import /run/agenix/tls-joel.tokyo
      }

      ${fqdn} {
        import joel.tokyo
        respond "Hello world"
      }

      syncthing.${fqdn} {
        import joel.tokyo
        reverse_proxy 172.17.0.1:8384
      }

      ipfs.${fqdn} {
        import joel.tokyo
        respond "Hello world"
      }
    '';
  };

  virtualisation.virtualbox.host.enable = true;
}
