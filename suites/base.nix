{ profiles, ... }:
{
  imports = with profiles; [
    common
    file-sync
    locale
    networking
    ssh
    ./users.nix
    vpn
  ];
}
