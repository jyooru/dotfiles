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
      device = "/dev/disk/by-id/wwn-0x5000cca5f6c52022";
      version = 2;
    };
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/37e514fd-92d1-4f34-9a8f-ee32f083386c";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.firewall.lan.interfaces = [ "enp0s25" ];

  services = {
    ipfs.swarmAddress = [
      "/ip4/0.0.0.0/tcp/4001"
      "/ip6/::/tcp/4001"
      "/ip4/0.0.0.0/udp/4001/quic"
      "/ip6/::/udp/4001/quic"
    ];

    nebula.networks."joel".listen.port = 4241;

    yggdrasil.config.Listen = [ "tls://[::]:20071" ];
  };
}
