{ pkgs, system }:

let
  inherit (import ../overlays/node-packages/composition.nix {
    inherit pkgs system;
  }) ttf2woff2;
in

with pkgs;

rec {
  atto = callPackage ./atto { };

  caddy-modded = callPackage ./caddy-modded { };

  jisho-api = callPackage ./jisho-api { };

  nakatoshi = callPackage ./nakatoshi { };

  nano-node = callPackage ./nano-node { };

  nano-vanity = callPackage ./nano-vanity { };

  nano-work-server = callPackage ./nano-work-server { };

  nerdfonts-woff2 = callPackage ./nerdfonts-woff2 { inherit ttf2woff2; };
  nerdfonts-woff2-firacode = callPackage ./nerdfonts-woff2 {
    inherit ttf2woff2;
    nerdfonts = nerdfonts.override { fonts = [ "FiraCode" ]; };
  };

  simpleygggen-cpp = callPackage ./simpleygggen-cpp { };

  timetable = callPackage ./timetable { };

  vanieth = callPackage ./vanieth { };

  vanity-monero = callPackage ./vanity-monero { };
}
