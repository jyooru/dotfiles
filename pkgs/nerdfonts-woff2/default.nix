{ lib, stdenv, nerdfonts, ttf2woff2, python3 }:
stdenv.mkDerivation rec {
  pname = "nerdfonts-woff2";
  inherit (nerdfonts) version;

  src = ./.;

  nativeBuildInputs = [ nerdfonts ttf2woff2 python3 ];

  buildPhase = ''
    python3 build.py "${nerdfonts}"
  '';

  installPhase = ''
    mkdir -p "$out/share/fonts/NerdFonts/woff2"
    cp -r output/* "$out/share/fonts/NerdFonts/woff2"
    cp -r ${nerdfonts}/* "$out"
  '';

  meta = with lib;{
    description = "Nerd Fonts in additional WOFF2 format";
    license = licenses.mit;
    maintainers = [ maintainers.jyooru ];
    platforms = platforms.all;
  };
}
