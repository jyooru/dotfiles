{ config, ... }:

{
  networking.firewall.interfaces."docker0".allowedTCPPorts = [ 8002 ];
  virtualisation.oci-containers.containers = {
    "vaultwarden" = {
      image = "vaultwarden/server";
      ports = [ "8002:80" ];
      environment = {
        DOMAIN = "https://vaultwarden.${config.networking.domain}";
        SIGNUPS_ALLOWED = "false";
        WEBSOCKET_ENABLED = "true";
      };
      volumes = [
        "/home/joel/node/data/vaultwarden:/data"
      ];
    };
  };
}
