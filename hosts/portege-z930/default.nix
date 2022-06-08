{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../profiles/servers/vaultwarden

    ../../suites/server
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot/efi";
    initrd.luks.devices.crypt1 = {
      device = "/dev/disk/by-uuid/79fff45f-671c-45e4-8eb0-d9f3d855942a";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.firewall.lan.interfaces = [ "enp0s25" ];

  services = {
    ipfs.swarmAddress = [
      "/ip4/0.0.0.0/tcp/4003"
      "/ip6/::/tcp/4003"
      "/ip4/0.0.0.0/udp/4003/quic"
      "/ip6/::/udp/4003/quic"
    ];

    nebula.networks."joel".listen.port = 4243;

    yggdrasil.config.Listen = [ "tls://[::]:20073" ];
  };
}
