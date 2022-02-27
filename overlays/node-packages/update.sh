#!/bin/sh

node2nix -14 -c composition.nix -i node-packages.json

deadnix --edit .
nixpkgs-fmt .
statix fix .
