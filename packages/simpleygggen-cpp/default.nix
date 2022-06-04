{ lib, stdenv, fetchFromGitea, libsodium, cmake }:
stdenv.mkDerivation rec {
  pname = "simpleygggen-cpp";
  version = "5.1";

  src = fetchFromGitea {
    domain = "notabug.org";
    owner = "acetone";
    repo = "SimpleYggGen-CPP";
    rev = version;
    hash = "sha256-jW1AMQZ8tmIrFRYzMGNP7XBfVg7iJdIEMopF4XR+P44=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ libsodium ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./src/sygcpp $out/bin
  '';

  meta = with lib; {
    description = "Simple Yggdrasil address miner in C++";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ jyooru ];
  };
}
