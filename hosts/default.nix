{ utils }:

with builtins;
with utils.lib;

mapAttrs
  (_: value:
    {
      modules = [ value ];
    }
  )
  (exportModules [
    ./ga-z77-d3h
    ./portege-r700-a
    # ./portege-r700-b
    ./portege-z930
    ./thinkpad-e580
  ])
