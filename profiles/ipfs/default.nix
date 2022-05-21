{ config, pkgs, ... }:
{
  environment.variables.IPFS_PATH = config.services.ipfs.dataDir;

  services.ipfs = {
    enable = true;
    enableGC = true;
    emptyRepo = true; # no help files
    localDiscovery = true;
    swarmAddress =
      let port = toString (import ./ports.nix).${config.networking.hostName}; in
      [
        "/ip4/0.0.0.0/tcp/${port}"
        "/ip6/::/tcp/${port}"
        "/ip4/0.0.0.0/udp/${port}/quic"
        "/ip6/::/udp/${port}/quic"
      ];
  };

  systemd.services.ipfs.serviceConfig.ExecStartPost = "${pkgs.coreutils}/bin/chmod g+r /var/lib/ipfs/config";
}
