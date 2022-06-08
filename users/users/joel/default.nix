{ pkgs, ... }:
{
  home-manager.users.joel = {
    imports = [ ../../suites/base ];

    programs.git = {
      signing.key = "33CA5F24";
      signing.signByDefault = true;
      userEmail = "joel@joel.tokyo";
      userName = "Joel";
    };
  };

  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "autologin" "docker" "ipfs" "wheel" ];
    shell = pkgs.fish;
  };
}
