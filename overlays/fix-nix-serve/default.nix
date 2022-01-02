final: prev:
{
  nix-serve = prev.nix-serve.override { nix = prev.nix_2_3; }; # https://github.com/edolstra/nix-serve/issues/28
}
