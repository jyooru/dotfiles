let
  inherit (builtins) currentSystem getFlake;
  inherit (flake) inputs;
  inherit (pkgs) lib;
  inherit (lib) recurseIntoAttrs;

  flake = getFlake (toString ./.);
  pkgs = import inputs.nixpkgs { inherit system; };
  system = currentSystem;
in
{
  checks = recurseIntoAttrs flake.checks.${system};
  devShell = flake.devShell.${system};
  overlays = import ./overlays/ci.nix { inherit inputs lib pkgs system; };
  packages = recurseIntoAttrs flake.packages.${system};
}
