#!/usr/bin/env fish

set root (pwd)

cd "$root" &&
    nix flake update &&
    nix flake lock && # make sure all lockfile changes are committed
    git add . &&
    git commit -m "chore(flake): update"

cd "$root/packages/timetable" &&
    cargo update &&
    read -p "echo Please update cargoSha256 in packages/timetable/default.nix and press enter..." &&
    git add . &&
    git commit -m "chore(packages.timetable): update"

cd "$root/overlays/node-packages" &&
    ./update.sh &&
    git add . &&
    git commit -m "chore(overlays.node-packages): update"

cd "$root/overlays/vscode-extensions" &&
    ./update.fish &&
    git add . &&
    git commit -m "chore(overlays.vscode-extensions): update"

# packages.caddy-modded
# once caddy updates dependencies and fixes ambiguous import
# cd "$root/packages/caddy-modded" && ./update.sh && git add . && git commit -m "chore(packages.caddy-modded): update"
