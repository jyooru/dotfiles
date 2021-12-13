{ config, lib, ... }:

with lib;

let
  cfg = config.modules.config.distributedBuild;
in

{
  options.modules.config.distributedBuild = {
    enable = mkEnableOption "Distributed build";
  };
  config = mkIf cfg.enable {
    nix = {
      buildMachines = (map
        (values: {
          systems = [ "x86_64-linux" "aarch64-linux" "armv6l-linux" ];
          sshUser = "joel";
          sshKey = "/home/joel/.ssh/id_rsa";
        } // values // { hostName = "${values.hostName}.${config.networking.domain}"; })
        [
          { maxJobs = 4; speedFactor = 1; hostName = "portege-r700-a"; }
          { maxJobs = 4; speedFactor = 1; hostName = "portege-r700-b"; }
          { maxJobs = 4; speedFactor = 3; hostName = "portege-z930"; }
          { maxJobs = 8; speedFactor = 4; hostName = "ga-z77-d3h"; }
        ]);
      distributedBuilds = true;
      extraOptions = ''
        builders-use-substitutes = true
      ''; # build machines download dependencies themselves instead of this host uploading them
    };
  };
}
