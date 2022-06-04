{ lib, pkgs, ... }:

with lib;
with pkgs;

{
  home.packages = [
    gopls
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    python3Packages.python-lsp-server
    rnix-lsp
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "paradise_dark";
      editor = {
        idle-timeout = 0;
        lsp.display-messages = true;
      };
      keys.normal = {
        space.w = ":w";
        space.q = ":q";
      };
    };

    themes.paradise_dark = importTOML ./paradise_dark.toml;
  };
}
