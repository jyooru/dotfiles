{ config, ... }:

let
  domain = "vaultwarden.${config.networking.domain}";
  port = 8002;
in
{
  services = {
    caddy.virtualHosts.${domain}.extraConfig = ''
      import tls
      reverse_proxy 127.0.0.1:${toString port}
    '';

    vaultwarden = {
      enable = true;
      config = {
        domain = "https://${domain}";
        rocketPort = port;
        signupsAllowed = false;
      };
    };
  };
}
