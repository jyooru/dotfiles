let
  overlays = [
    "dedicated-gpu"
    "fix-nix-serve"
    "node-packages"
    "pkgs"
    "xsecurelock"
  ];
in
builtins.listToAttrs (map (name: { inherit name; value = import (./. + "/${name}"); }) overlays)
