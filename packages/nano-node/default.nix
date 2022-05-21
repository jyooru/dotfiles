{ lib
, stdenv
, fetchFromGitHub
, libsodium
, cmake
, boost170
, git
}:
stdenv.mkDerivation rec {
  pname = "nano-node";
  version = "24.0DB2";

  src = fetchFromGitHub {
    owner = "nanocurrency";
    repo = pname;
    rev = "V${version}";
    sha256 = "0zl8i5cvkckpgj5zz3zc3h16c9jxsy6xr8110d7jcfvv3vch1nlj";
    fetchSubmodules = true;
  };

  cmakeFlags = "-DBOOST_ROOT=${boost170} -DNANO_SHARED_BOOST=ON";

  nativeBuildInputs = [ cmake git ];

  buildInputs = [ boost170 ];

  buildPhase = ''
    runHook preBuild
    make -j $NIX_BUILD_CORES nano_node
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv nano_node $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "Nano is a cryptocurrency";
    license = licenses.bsd3;
    maintainers = with maintainers; [ jyooru ];
  };
}
