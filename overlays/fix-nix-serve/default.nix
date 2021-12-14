_: super:
{
  nix-serve = super.nix-serve.override { nix = super.nix_2_3; }; # https://github.com/edolstra/nix-serve/issues/28
}
