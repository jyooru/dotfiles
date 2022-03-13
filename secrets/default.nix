with builtins;

let
  secrets = attrNames (import ./secrets.nix);
in

listToAttrs
  (map
    (name: {
      name = replaceStrings [ ".age" ] [ "" ] name;
      value = ./. + "/${name}";
    })
    secrets)
