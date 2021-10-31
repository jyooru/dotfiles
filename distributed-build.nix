{
  nix.buildMachines = [
    {
      hostName = "portege-r700-a";
      systems = [ "x86_64-linux" "armv6l-linux" ];
      maxJobs = 2;
      speedFactor = 1;
      supportedFeatures = [ ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "portege-r700-b";
      systems = [ "x86_64-linux" "armv6l-linux" ];
      maxJobs = 2;
      speedFactor = 1;
      supportedFeatures = [ ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "portege-z930";
      systems = [ "x86_64-linux" "armv6l-linux" ];
      maxJobs = 3;
      speedFactor = 3;
      supportedFeatures = [ ];
      mandatoryFeatures = [ ];
    }
    {
      hostName = "ga-z77-d3h";
      systems = [ "x86_64-linux" "armv6l-linux" ];
      maxJobs = 4;
      speedFactor = 4;
      supportedFeatures = [ ];
      mandatoryFeatures = [ ];
    }
  ];

  nix.distributedBuilds = true;

  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
