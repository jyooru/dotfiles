{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../suites/server
  ];

  boot = {
    loader.grub = {
      enable = true;
      enableCryptodisk = true;
      device = "/dev/disk/by-id/wwn-0x5000cca5b7f2354f";
      version = 2;
    };
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/c7206449-23ca-4268-bfc5-23929d0422bc";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.firewall.lan.interfaces = [ "enp0s25" ];

  services = {
    ipfs.swarmAddress = [
      "/ip4/0.0.0.0/tcp/4002"
      "/ip6/::/tcp/4002"
      "/ip4/0.0.0.0/udp/4002/quic"
      "/ip6/::/udp/4002/quic"
    ];

    nebula.networks."joel".listen.port = 4242;

    yggdrasil.config.Listen = [ "tls://[::]:20072" ];
  };
}
