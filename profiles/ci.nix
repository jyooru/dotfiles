{ config, ... }:
let
  buildMachines = builtins.listToAttrs (map
    (value: { name = value.hostName; inherit value; })
    (import ./distributed-build.nix { inherit config; }).nix.buildMachines
  );

  inherit (config.networking) fqdn;
in
{
  services.hercules-ci-agent = {
    enable = true;
    concurrentTasks = buildMachines.${fqdn}.maxJobs;
  };
}
