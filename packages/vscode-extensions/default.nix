{ lib, vscode-utils }:
let
  inherit (lib) foldr importJSON;
  inherit (vscode-utils) buildVscodeMarketplaceExtension;
in

lib.foldr (a: b: a // b) { } (map
  (extension:
    {
      ${extension.publisher}.${extension.name} = buildVscodeMarketplaceExtension {
        mktplcRef = {
          inherit (extension) name publisher version sha256;
        };
      };
    })
  (importJSON ./sources.json)
)
