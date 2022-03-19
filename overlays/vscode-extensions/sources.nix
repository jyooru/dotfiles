{ lib, vscode-utils }:

let
  inherit (lib) foldr importJSON recursiveUpdate;
  inherit (vscode-utils) buildVscodeMarketplaceExtension;
in

foldr recursiveUpdate { }
  (map
    (extension: {
      ${extension.publisher}.${extension.name} = buildVscodeMarketplaceExtension {
        mktplcRef = {
          inherit (extension) name publisher version sha256;
        };
      };
    })
    (importJSON ./sources.json)
  )
