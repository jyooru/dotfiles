{ config, lib, ... }:

with lib;

{
  networking.firewall.interfaces = genAttrs [ "nebula0" "ygg0" ] (_: {
    allowedTCPPorts = config.services.openssh.ports;
    allowedUDPPortRanges = [{ from = 60000; to = 61000; }]; # mosh
  });

  programs.mosh.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = false;
    passwordAuthentication = false;
  };
}
