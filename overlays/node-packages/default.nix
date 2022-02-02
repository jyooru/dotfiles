final: prev:
{
  nodePackages = prev.nodePackages // (import ./composition.nix {
    pkgs = final;
    inherit (final) system;
  });
}
