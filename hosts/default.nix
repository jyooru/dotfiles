let
  hosts = [
    "ga-z77-d3h"
    "portege-r700-a"
    "portege-r700-b"
    "portege-z930"
    "thinkpad-e580"
  ];
in

with builtins;

listToAttrs (
  map
    (name: {
      inherit name;
      value = {
        modules = [
          (import (./. + "/${name}"))
        ];
      };
    })
    hosts
)
