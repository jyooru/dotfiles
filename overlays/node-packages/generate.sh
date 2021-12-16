#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nodePackages.node2nix

node2nix -14 -c composition.nix -i node-packages.json
