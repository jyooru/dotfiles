final: prev:
{
  nebula = prev.nebula.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (final.fetchpatch {
        url = "https://github.com/slackhq/nebula/pull/548.patch";
        hash = "sha256-3CG+eHjKo2ruwhAjwLF43m3xKLnjpHTveS1NpLNLS/I=";
      })
    ];
  });
}
