{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/servers/hercules-ci
    ../../profiles/servers/minecraft

    ../../suites/server
  ];

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

  networking.firewall.lan.interfaces = [ "enp4s0" ];

  services = {
    ipfs.swarmAddress = [
      "/ip4/0.0.0.0/tcp/4001"
      "/ip6/::/tcp/4001"
      "/ip4/0.0.0.0/udp/4001/quic"
      "/ip6/::/udp/4001/quic"
    ];

    nebula.networks."joel".listen.port = 4244;

    yggdrasil.config.Listen = [ "tls://[::]:20074" ];
  };
  systemd.services.nix-serve.environment.HOME = "/dev/null";
}
