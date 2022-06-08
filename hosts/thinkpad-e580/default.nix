{ config, inputs, pkgs, secrets, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/nodes/alfis
    ../../profiles/interactive
    ../../profiles/nodes/ipfs
    ../../profiles/networks/yggdrasil

    ../../suites/base

    ../../users/users/joel/gui.nix
  ] ++ (with inputs.hardware.nixosModules;
    [
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

  users.users.root.openssh.authorizedKeys.keyFiles = [ ./keys/ssh-root.pub ]; # deploy

  services = {
    ipfs.swarmAddress = [
      "/ip4/0.0.0.0/tcp/4000"
      "/ip6/::/tcp/4000"
      "/ip4/0.0.0.0/udp/4000/quic"
      "/ip6/::/udp/4000/quic"
    ];

    # this host isn't a lighthouse, but all hosts should have a unique port for NAT traversal to avoid overlaps
    nebula.networks."joel".listen.port = 4240;

    tlp.enable = true;

    # something automatically generates this - adding nixos-hardware.nixosModules.common-gpu-amd overrides it
    # so also add the automatically generated stuff so X works
    xserver.videoDrivers = [ "amdgpu" "radeon" "nouveau" "modesetting" "fbdev" ];
  };


  networking.firewall = {
    interfaces."nebula0".allowedTCPPorts = [ 80 443 8080 ];

    lan = {
      allowedTCPPorts = [ 6567 25565 ];
      allowedUDPPorts = [ 6567 ];
      interfaces = [ "wlp5s0" "enp0s20f0u2u1" ];
    };
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
        reverse_proxy localhost:8384 { 
          header_up Host localhost:8384
        }
      }

      ipfs.${fqdn} {
        import joel.tokyo
        respond "Hello world"
      }
    '';
  };

  virtualisation.virtualbox.host.enable = true;

  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    scrcpy # android screen mirroring tool
    heimdall # samsung device custom recovery installer
  ];

  nix = {
    buildMachines = [
      {
        hostName = "ga-z77-d3h.${config.networking.domain}";
        maxJobs = 4;
        speedFactor = 4;
        sshUser = "joel";
        systems = [ "x86_64-linux" "aarch64-linux" "armv6l-linux" ];
      }
    ];
    distributedBuilds = true;
    settings.builders-use-substitutes = true;
  };
}
