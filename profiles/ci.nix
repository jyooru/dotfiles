{ config, ... }:
let
  inherit (config.networking) fqdn;

  buildMachines = builtins.listToAttrs (map
    (value: { name = value.hostName; inherit value; })
    (import ./distributed-build.nix { inherit config; }).nix.buildMachines
  );
in
{
  services.hercules-ci-agent = {
    enable = true;
    settings.concurrentTasks = buildMachines.${fqdn}.maxJobs;
  };
}
