{ pkgs, system, nodejs }:
let
  nodePackages = (import ../../overlays/node-packages/composition.nix {
    inherit pkgs system nodejs;
  });
in
nodePackages.ttf2woff2
