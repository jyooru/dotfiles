let
  overlays = {
    # customisations
    customiseDedicatedGPU = ./customise-dedicated-gpu;
    customiseQtile = ./customise-qtile;
    customiseXsecurelock = ./customise-xsecurelock;

    # fixes
    fixNebula = ./fix-nebula;

    # package sets
    nodePackages = ./node-packages;
    packages = ./packages;
    vscodeExtensions = ./vscode-extensions;
  };
in
builtins.mapAttrs (_: path: import path) overlays
