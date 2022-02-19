#!/bin/sh

node2nix -14 -c composition.nix -i node-packages.json
nixpkgs-fmt .
