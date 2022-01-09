let
  overlays = {
    dedicatedGPU = "dedicated-gpu";
    fixNebula = "fix-nebula";
    fixNixServe = "fix-nix-serve";
    nodePackages = "node-packages";
    packages = "packages";
    xsecurelock = "xsecurelock";
  };
in
builtins.mapAttrs (_: path: import (./. + "/${path}")) overlays
