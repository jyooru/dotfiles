{ pkgs }:
with pkgs;
rec {
  caddy-modded = callPackage ./caddy-modded { };

  min-firefox = callPackage ./min-firefox { };

  nerdfonts-woff2 = callPackage ./nerdfonts-woff2 { inherit ttf2woff2; };
  nerdfonts-woff2-firacode = callPackage ./nerdfonts-woff2 {
    inherit ttf2woff2;
    nerdfonts = nerdfonts.override { fonts = [ "FiraCode" ]; };
  };

  ttf2woff2 = callPackage ./ttf2woff2 { };

  vscode-extensions = recurseIntoAttrs (callPackage ./vscode-extensions { });
}
