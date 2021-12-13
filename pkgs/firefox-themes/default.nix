{ lib, stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "FirefoxThemes";
  version = "47a0dc5a78e22a37bb448b60bfdf3a691ebda044";

  src = fetchFromGitHub {
    owner = "CristianDragos";
    repo = "FirefoxThemes";
    rev = version;
    sha256 = "1r38k90w5zvfg8z5mbkaj656xpajzxrqkxhxg8ag50wxlzbkz8ad";
  };

  dontBuild = true;
  installPhase = ''
    cp -r . $out
  '';

  patches = [ ./colors.patch ];

  meta = with lib;{
    homepage = "https://github.com/CristianDragos/FirefoxThemes";
    license = licenses.gpl3Only;
    maintainers = [ maintainers.jyooru ];
    platforms = platforms.all;
  };
}
