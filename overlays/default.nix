let
  overlays = {
    dedicatedGPU = "dedicated-gpu";
    fixNebula = "fix-nebula";
    fixNixServe = "fix-nix-serve";
    nodePackages = "node-packages";
    packages = "packages";
    xsecurelock = "xsecurelock";

    qtile = "qtile"; # fixes and features, would put this in packages.qtile-modded but the module does not support custom packages
  };
in
builtins.mapAttrs (_: path: import (./. + "/${path}")) overlays
