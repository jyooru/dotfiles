#!/usr/bin/env nix-shell
#!nix-shell -i fish -p fish git

set root (pwd)


# flake
# `nix flake lock`: make sure all lockfile changes are committed - some lockfile changes happen when using the flake (eg nixos-rebuild)
cd "$root" && nix flake update && nix flake lock && git add . && git commit -m "chore(flake): update"

# overlays.node-packages
cd "$root/overlays/node-packages" && ./update.sh && git add . && git commit -m "chore(overlays.node-packages): update"

# packages.caddy-modded
# once i fix ambiguous import
# cd "$root/packages/caddy-modded" && ./update.sh && git add . && git commit -m "chore(packages.caddy-modded): update"
