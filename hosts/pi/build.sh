nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage --argstr system armv6l-linux -I nixos-config=./sd-image.nix
