{ profiles, ... }:
{
  imports = with profiles; [
    ./base.nix
    server
  ];
}
