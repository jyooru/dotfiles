{ lib, stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "min-firefox";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "CristianDragos";
    repo = "FirefoxThemes";
    rev = "47a0dc5a78e22a37bb448b60bfdf3a691ebda044";
    sha256 = "1r38k90w5zvfg8z5mbkaj656xpajzxrqkxhxg8ag50wxlzbkz8ad";
  };

  patches = [
    ./colors.patch
    ./description.patch
  ];

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
