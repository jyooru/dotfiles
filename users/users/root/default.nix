{ pkgs, ... }:
{
  home-manager.users.root.imports = [ ../../suites/base ];

  users.users.root.shell = pkgs.fish;
}
