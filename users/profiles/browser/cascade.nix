{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  name = "cascade";

  src = fetchFromGitHub {
    owner = "andreasgrafen";
    repo = name;
    rev = "45d558abbf856b2f198898278af1be4992e3baa2";
    hash = "sha256-7Nvlb6kBECLr6IsPEz2opoNcyDsZ7DkDN8cN6GDI3UQ=";
  };

  buildPhase = ''
    sed -i "s/#1E2021/#151515/
            s/#191B1C/#151515/
            s/#FAFAFC/#BBB6B6/" userChrome.css
  '';

  installPhase = ''
    cp userChrome.css $out
  '';
}
