{ hmUsers, pkgs, ... }:
{
  home-manager.users = {
    inherit (hmUsers) root;
  };

  users.users.root.shell = pkgs.fish;
}
