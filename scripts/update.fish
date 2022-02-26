#!/usr/bin/env fish

set root (pwd)

cd "$root" &&
    nix flake update &&
    nix flake lock && # make sure all lockfile changes are committed
    git add . &&
    git commit -m "chore(flake): update"

cd "$root/overlays/node-packages" &&
    ./update.sh &&
    git add . &&
    git commit -m "chore(overlays.node-packages): update"

cd "$root/overlays/vscode-extensions" &&
    ./update.fish &&
    git add . &&
    git commit -m "chore(overlays.vscode-extensions): update"

# packages.caddy-modded
# once i fix ambiguous import
# cd "$root/packages/caddy-modded" && ./update.sh && git add . && git commit -m "chore(packages.caddy-modded): update"
