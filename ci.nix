let
  inherit (builtins) currentSystem getFlake;
  inherit (pkgs) lib;
  inherit (lib) recurseIntoAttrs;

  flake = getFlake (toString ./.);
  pkgs = flake.legacyPackages.${currentSystem};
in
{
  checks = recurseIntoAttrs flake.checks.${currentSystem};
  devShell = flake.devShell.${currentSystem};
  pi-sd-image = flake.nixosConfigurations.pi.config.system.build.sdImage;
  packages = recurseIntoAttrs flake.packages.${currentSystem};
}
