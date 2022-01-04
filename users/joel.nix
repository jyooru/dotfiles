{ hmUsers, pkgs, ... }:
{
  imports = [{ home-manager.users = { inherit (hmUsers) joel; }; };]; # lets me add more home-manager.users.joel config below

  home-manager.users.joel.programs.git = {
    enable = true;
    signing.key = "33CA5F24";
    signing.signByDefault = true;
    userEmail = "joel@joel.tokyo";
    userName = "Joel";
  };

  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "autologin" "docker" "wheel" ];
    shell = pkgs.fish;
  };
}
