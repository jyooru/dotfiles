final: prev:

let
  unwrapped = prev.qtile.passthru.unwrapped.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./play-pause-icons.patch
    ];

    propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ (with final.python3Packages; [
      dbus-next
    ]);
  });
in

{
  qtile = (final.python3.withPackages (_: [ unwrapped ])).overrideAttrs
    (_: {
      name = "${unwrapped.pname}-${unwrapped.version}";
      passthru = { inherit unwrapped; };
    });
}
