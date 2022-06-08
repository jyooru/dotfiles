{ config, lib, ... }:

with lib;

let
  inherit (config.networking) domain fqdn hostName;

  devices = mapAttrs
    (name: id: { addresses = [ "tcp://${name}.${domain}:22000" ]; inherit id; })
    (import ./ids.nix);

  folders = mapAttrs
    (name: values: values // { path = ''/home/joel${if (elem hostName specialDevices) && (!(elem name specialFolders)) then "/files" else ""}/'' + name; })
    (import ./folders.nix);
  # TODO: remove special*
  specialDevices = [ "portege-r700-a" "portege-r700-b" "portege-z930" "ga-z77-d3h" ];
  specialFolders = [ "cluster" "tmp" ]; # folders not in this list are put in ~/files on cluster nodes
in

{
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "204800";
  };

  networking.firewall.interfaces."nebula0" = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };

  services = {
    caddy.virtualHosts."syncthing.${fqdn}".extraConfig = ''
      import tls
      reverse_proxy localhost:8384 { 
        header_up Host localhost:8384
      }
    '';

    syncthing = {
      enable = true;
      user = "joel";
      group = "users";
      configDir = "/home/joel/.config/syncthing";
      dataDir = "/home/joel";
      systemService = true;

      devices = removeAttrs devices [ hostName ];
      folders = mapAttrs
        (_: folder: folder // { devices = remove hostName folder.devices; })
        (filterAttrs (_: v: elem hostName v.devices) folders);

      extraOptions.options = {
        # all devices use my nebula network
        globalAnnounceEnabled = false;
        localAnnounceEnabled = false;
        natEnabled = false;
        relaysEnabled = false;
      };
    };
  };
}
