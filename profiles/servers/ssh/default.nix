{ config, lib, ... }:

with lib;

let
  allowedPorts = {
    allowedTCPPorts = config.services.openssh.ports;
    allowedUDPPortRanges = [{ from = 60000; to = 61000; }]; # mosh
  };
in

{
  networking.firewall = {
    interfaces = genAttrs [ "nebula0" "ygg0" ] (_: allowedPorts);
    lan = allowedPorts;
  };

  programs.mosh.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = false;
    passwordAuthentication = false;
  };
}
