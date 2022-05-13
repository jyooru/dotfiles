with builtins;

let
  flake = getFlake (toString ./.);
in

with flake.inputs.nixpkgs.lib;
with flake;

{
  devShells = recurseIntoAttrs { default = devShells.${currentSystem}.default; };
  nixosConfigurations = recurseIntoAttrs (mapAttrs (_: value: value.config.system.build.toplevel) nixosConfigurations);
  overlays = import ./overlays/ci.nix { inherit inputs; };
  packages = recurseIntoAttrs packages.${currentSystem};
}
