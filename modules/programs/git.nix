{ config, pkgs, ... }:
{
  programs.git = {
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
}
