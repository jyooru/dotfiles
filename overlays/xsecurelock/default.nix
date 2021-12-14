_: super:
{
  xsecurelock = super.xsecurelock.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./xsecurelock.patch
    ];
  });
}
