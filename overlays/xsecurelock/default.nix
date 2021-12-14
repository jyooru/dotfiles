_: super:
{
  xsecurelock = super.xsecurelock.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      # I am not a C developer.
      ./hide-asterisks.patch
      ./hide-keyboard-layout.patch
    ];
  });
}
