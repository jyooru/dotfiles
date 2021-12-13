#!/bin/sh


set -e


cd modules

echo "{ imports = [" > default.nix
find . -type f -name "*.nix" | grep -v "./default.nix" | sort >> default.nix
echo "]; }" >> default.nix

nixpkgs-fmt default.nix
