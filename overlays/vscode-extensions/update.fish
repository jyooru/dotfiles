#!/usr/bin/env nix-shell
#!nix-shell -i fish -p fish nixpkgs-fmt nodePackages.prettier

set sources (readlink -f sources.sh) # full path
set nixpkgs (nix eval --expr 'let flake = builtins.getFlake (toString ../..); in flake.inputs.nixpkgs.outPath' --impure --raw)

$nixpkgs/pkgs/misc/vscode-extensions/update_installed_exts.sh $sources > sources.nix
nix eval --expr '(import ./sources.nix).extensions' --json --impure > sources.json

prettier -w sources.json
rm sources.nix