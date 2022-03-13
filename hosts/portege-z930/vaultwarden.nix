{ config, ... }:

{
  networking.firewall.interfaces."docker0".allowedTCPPorts = [ 8002 ];
  services.vaultwarden = {
    enable = true;
    config = {
      domain = "https://vaultwarden.${config.networking.domain}";
      rocketAddress = "172.17.0.1";
      rocketPort = 8002;
      signupsAllowed = false;
    };
  };
}
