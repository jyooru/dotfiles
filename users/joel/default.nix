{ hmUsers, pkgs, ... }:
{
  imports = [ ./git.nix ];

  home-manager.users = {
    inherit (hmUsers) joel;
  };

  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "autologin" "docker" "wheel" ];
    shell = pkgs.fish;
  };
}
