self: super:
let
  inherit (self) callPackage;
in
rec {
  firefox-themes = callPackage ./firefox-themes { };
}
