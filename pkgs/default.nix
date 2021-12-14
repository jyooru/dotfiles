{ pkgs }:
let
  inherit (pkgs) callPackage;
in
rec {
  firefox-themes = callPackage ./firefox-themes { };
}
