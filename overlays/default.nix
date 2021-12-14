let
  overlays = [
    "dedicated-gpu"
    "fix-nix-serve"
    "xsecurelock"
  ];
in
builtins.listToAttrs (map (name: { inherit name; value = import (./. + "/${name}"); }) overlays) // {
  pkgs = (pkgs: _: import ../pkgs { inherit pkgs; });
}
