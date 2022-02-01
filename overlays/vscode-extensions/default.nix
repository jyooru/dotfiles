final: prev:
{
  vscode-extensions = prev.vscode-extensions // import ./sources.nix {
    inherit (final) lib vscode-utils;
  };
}
