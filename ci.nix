let
  inherit (builtins) currentSystem;
  inherit (pkgs) lib;
  inherit (lib) recurseIntoAttrs;

  flake = (import
    (
      let lock = builtins.fromJSON (builtins.readFile ./flake.lock); in
      fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
        sha256 = lock.nodes.flake-compat.locked.narHash;
      }
    )
    { src = ./.; }
  ).defaultNix;

  pkgs = flake.legacyPackages.${currentSystem};
in
{
  devShell = flake.devShell.${currentSystem};
  packages = recurseIntoAttrs flake.packages.${currentSystem};
}
