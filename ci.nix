with builtins;

let
  flake = getFlake (toString ./.);
in

with flake.inputs.nixpkgs.lib;
with flake;

{
  devShells = recurseIntoAttrs devShells.${currentSystem};
  nixosConfigurations = recurseIntoAttrs (mapAttrs (_: value: value.config.system.build.toplevel) nixosConfigurations);
  overlays = import ./overlays/ci.nix { inherit inputs; };
  packages = recurseIntoAttrs packages.${currentSystem};
}
