{ pkgs, system }:

with pkgs;

rec {
  atto = callPackage ./atto { };

  caddy-modded = callPackage ./caddy-modded { };

  jisho-api = callPackage ./jisho-api { };

  nakatoshi = callPackage ./nakatoshi { };

  nano-node = callPackage ./nano-node { };

  nano-vanity = callPackage ./nano-vanity { };

  nano-work-server = callPackage ./nano-work-server { };

  simpleygggen-cpp = callPackage ./simpleygggen-cpp { };

  timetable = callPackage ./timetable { };

  vanieth = callPackage ./vanieth { };

  vanity-monero = callPackage ./vanity-monero { };
}
