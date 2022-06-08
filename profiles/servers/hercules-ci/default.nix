{ config, ... }:

with config.networking;

{
  services = {
    caddy.virtualHosts."nix.${fqdn}".extraConfig = with config.services.nix-serve; ''
      import tls
      reverse_proxy ${bindAddress}:${toString port}
    '';

    hercules-ci-agent = {
      enable = true;
      settings.concurrentTasks = 4;
    };

    nix-serve = {
      enable = true;
      secretKeyFile = "/var/binary-cache.pem";
    };
  };

  systemd.services.nix-serve.environment.HOME = "/dev/null";
}
