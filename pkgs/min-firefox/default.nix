{ lib, stdenv, fetchFromGitHub, firefox-themes, git }:
stdenv.mkDerivation rec {
  pname = "min-firefox";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ git ];

  buildPhase = ''
    cp -Lr --no-preserve=mode ${firefox-themes}/* "."
    git apply "colors.patch" "description.patch"
  '';

  installPhase = ''
    cp -r "Simplify Darkish/Simplify Gray/" "$out"
  '';

  meta = with lib;{
    description = "Min theme for Firefox";
    license = licenses.gpl3Only;
    maintainers = [ maintainers.jyooru ];
    platforms = platforms.all;
  };
}
