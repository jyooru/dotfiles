{ inputs }:

let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs.lib) currentSystem getAttrs mapAttrs recurseIntoAttrs;

  pkgs = import nixpkgs { };
  system = currentSystem;

  overlays = import ./.;
  overlayPackages = {
    customiseDedicatedGPU = [ "minecraft" "steam" ];
    # customiseQtile = [ "qtile" ]; # wlroots fails to build
    customiseXsecurelock = [ "xsecurelock" ];

    fixNebula = [ "nebula" ];
  };
in

recurseIntoAttrs (
  (mapAttrs
    (overlay: packages:
      recurseIntoAttrs (
        let pkgs = import nixpkgs {
          config.allowUnfree = true;
          overlays = [ overlays.${overlay} ];
        };
        in
        getAttrs packages pkgs
      )
    )
    overlayPackages
  ) // {
    nodePackages = recurseIntoAttrs (import ./node-packages/composition.nix { inherit pkgs system; });
    vscodeExtensions = recurseIntoAttrs (import ./vscode-extensions/sources.nix { inherit (pkgs) lib vscode-utils; });
  }
)

