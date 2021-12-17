let
  overlays = {
    dedicatedGPU = "dedicated-gpu";
    fixNixServe = "fix-nix-serve";
    nodePackages = "node-packages";
    pkgs = "pkgs";
    xsecurelock = "xsecurelock";
  };
in
builtins.mapAttrs (_: path: import (./. + "/${path}")) overlays
