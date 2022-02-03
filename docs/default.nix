{ lib, stdenv, python3 }:
stdenv.mkDerivation {
  # no version so not pname
  name = "dotfiles-docs";

  src = ../.;

  nativeBuildInputs = [
    (python3.withPackages (ps: with ps; [ python-frontmatter ]))
  ];

  buildPhase = ''
    python3 docs/build.py 
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out
  '';

  meta = with lib;{
    # description = "";
    license = licenses.mit;
    maintainers = [ maintainers.jyooru ];
    platforms = platforms.all;
  };
}
