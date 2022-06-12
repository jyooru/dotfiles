let
  overlays = rec {
    default = packages;

    # customisations
    customiseDedicatedGPU = ./customise-dedicated-gpu;
    customiseQtile = ./customise-qtile;
    customiseXsecurelock = ./customise-xsecurelock;

    # fixes
    fixNebula = ./fix-nebula;

    # package sets
    packages = ./packages;
    vscodeExtensions = ./vscode-extensions;
  };
in

builtins.mapAttrs (_: import) overlays
