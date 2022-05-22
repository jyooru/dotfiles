{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  name = "cascade";

  src = fetchFromGitHub {
    owner = "andreasgrafen";
    repo = name;
    rev = "45d558abbf856b2f198898278af1be4992e3baa2";
    sha256 = "0i6xr1hfh3f76w1kkv0r7g45r0x6m0yi63wbx3mj4401m5pybnzc";
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
