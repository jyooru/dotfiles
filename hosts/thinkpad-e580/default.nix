{ config, inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/nodes/alfis
    ../../profiles/interactive
    ../../profiles/nodes/ipfs
    ../../profiles/networks/yggdrasil

    ../../suites/base

    ../../users/users/joel/gui.nix
  ] ++ (with inputs.hardware.nixosModules; [
    common-cpu-intel
    common-gpu-amd
    common-pc-laptop
    common-pc-laptop-ssd
  ]);

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
    ipfs = {
      # let's me still use offline ipfs without killing my battery
      # have an alias setup to turn it back on easily
      extraConfig.Swarm.ConnMgr.Type = "none";

      swarmAddress = [
        "/ip4/0.0.0.0/tcp/4000"
        "/ip6/::/tcp/4000"
        "/ip4/0.0.0.0/udp/4000/quic"
        "/ip6/::/udp/4000/quic"
      ];
    };

    # this host isn't a lighthouse, but all hosts should have a unique port for NAT traversal to avoid overlaps
    nebula.networks."joel".listen.port = 4240;

    tlp.enable = true;

    # something automatically generates this - adding nixos-hardware.nixosModules.common-gpu-amd overrides it
    # so also add the automatically generated stuff so X works
    xserver.videoDrivers = [ "amdgpu" "radeon" "nouveau" "modesetting" "fbdev" ];
  };


  networking.firewall = {
    interfaces."nebula0".allowedTCPPorts = [ 80 443 ];

    lan = {
      allowedTCPPorts = [ 6567 25565 ];
      allowedUDPPorts = [ 6567 ];
      interfaces = [ "wlp5s0" "enp0s20f0u2u1" ];
    };
  };

  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [ scrcpy ];

  nix = {
    buildMachines = [
      {
        hostName = "ga-z77-d3h.${config.networking.domain}";
        maxJobs = 4;
        speedFactor = 4;
        sshUser = "joel";
        systems = [ "x86_64-linux" ];
      }
    ];
    distributedBuilds = true;
    settings.builders-use-substitutes = true;
  };
}
