{ config, lib, ... }:

with lib;

let
  cfg = config.modules.programs.git;
in

{
  options.modules.programs.git = {
    enable = mkEnableOption "Version control system";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.git = {
      enable = true;
      signing.key = "33CA5F24";
      signing.signByDefault = true;
      userEmail = "joel@joel.tokyo";
      userName = "Joel";
      includes = [{
        contents = {
          init = { defaultBranch = "main"; };
          push = { default = "current"; };
          pull = { rebase = true; };
        };
      }];
    };
  };
}
