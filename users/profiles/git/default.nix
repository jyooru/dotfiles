{
  programs.git = {
    enable = true;
    ignores = [ "tmp" ];
    includes = [{
      contents = {
        init = { defaultBranch = "main"; };
        push = { default = "current"; };
        pull = { rebase = true; };
      };
    }];
  };
}
