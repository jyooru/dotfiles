{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) callPackage;
in
rec {
  firefox-themes = callPackage ./firefox-themes { };

  min-firefox = callPackage ./min-firefox { inherit firefox-themes; };
}
