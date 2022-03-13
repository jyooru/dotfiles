{ pkgs, ... }:
{
  home-manager.users.root.imports = [
    ./profiles/common
    ./profiles/git
    ./profiles/shell
    ./profiles/packages/tools.nix
    ./profiles/ssh
  ];

  users.users.root.shell = pkgs.fish;
}
