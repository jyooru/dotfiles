{ pkgs, system }:
let
  nodePackages = (import ../../overlays/node-packages/composition.nix {
    inherit pkgs system;
  });
in
nodePackages.ttf2woff2
