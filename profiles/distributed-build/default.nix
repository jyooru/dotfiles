{ config, ... }:
{
  nix = {
    buildMachines = [
      {
        hostName = "ga-z77-d3h.${config.networking.domain}";
        maxJobs = 8;
        speedFactor = 4;
        sshUser = "joel";
        systems = [ "x86_64-linux" "aarch64-linux" "armv6l-linux" ];
      }
    ];
    distributedBuilds = true;
    settings.builders-use-substitutes = true;
  };
}
