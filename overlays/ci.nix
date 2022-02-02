{ inputs, lib, pkgs, system }:
let
  inherit (inputs) nixpkgs;
  inherit (lib) getAttrs mapAttrs recurseIntoAttrs;

  overlays = import ./.;
  overlayPackages = {
    customiseDedicatedGPU = [ "minecraft" "steam" ];
    customiseQtile = [ "qtile" ];
    customiseXsecurelock = [ "xsecurelock" ];

    fixNebula = [ "nebula" ];
    fixNixServe = [ "nix-serve" ];
  };
in
recurseIntoAttrs (
  (mapAttrs
    (overlay: packages:
      recurseIntoAttrs (
        let pkgs = import nixpkgs {
          inherit system;
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

