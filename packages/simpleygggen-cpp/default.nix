{ lib, stdenv, fetchFromGitea, libsodium, cmake }:
stdenv.mkDerivation rec {
  pname = "simpleygggen-cpp";
  version = "5.1";

  src = fetchFromGitea {
    domain = "notabug.org";
    owner = "acetone";
    repo = "SimpleYggGen-CPP";
    rev = version;
    sha256 = "13izgrsf2ica682d49g21rb5yw7d9xik0cqn2lmn5dkw0qql0vcd";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ libsodium ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./src/sygcpp $out/bin
  '';

  meta = with lib; {
    description = "Simple Yggdrasil address miner in C++";
    license = licenses.glp3Only;
    maintainers = with maintainers; [ jyooru ];
  };
}
