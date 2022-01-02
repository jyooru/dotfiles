final: prev:
{
  nebula = prev.nebula.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (final.fetchpatch {
        url = "https://github.com/slackhq/nebula/pull/548.patch";
        sha256 = "1wjb9frs8k9dg7pp9973p4lg2vfyg2qw08qhqbp6m8yag1wbw8fw";
      })
    ];
  });
}
