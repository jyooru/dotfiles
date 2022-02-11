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
  };
in
recurseIntoAttrs (
  (mapAttrs
    (overlay: packages:
      recurseIntoAttrs (
        let pkgs = import nixpkgs {
          config.allowUnfree = true;
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

