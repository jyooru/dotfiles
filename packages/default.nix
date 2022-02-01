{ pkgs, system }:

let
  inherit (import ../overlays/node-packages/composition.nix {
    inherit pkgs system;
  }) ttf2woff2;
in
with pkgs;
rec {
  caddy-modded = callPackage ./caddy-modded { };

  min-firefox = callPackage ./min-firefox { };

  nerdfonts-woff2 = callPackage ./nerdfonts-woff2 { inherit ttf2woff2; };
  nerdfonts-woff2-firacode = callPackage ./nerdfonts-woff2 {
    inherit ttf2woff2;
    nerdfonts = nerdfonts.override { fonts = [ "FiraCode" ]; };
  };

  vscode-extensions = recurseIntoAttrs (callPackage ./vscode-extensions { });
}
