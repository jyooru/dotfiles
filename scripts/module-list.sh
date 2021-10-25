#!/bin/sh


set -e


cd modules

echo "[" > module-list.nix
find . -type f -name "*.nix" >> module-list.nix
echo "]" >> module-list.nix

nixpkgs-fmt module-list.nix
