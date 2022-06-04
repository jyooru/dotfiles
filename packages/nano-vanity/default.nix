{ lib, rustPlatform, fetchFromGitHub, ocl-icd }:
rustPlatform.buildRustPackage rec {
  pname = "nano-vanity";
  version = "0.4.13";

  src = fetchFromGitHub {
    owner = "plasmapower";
    repo = pname;
    rev = "3ba2ef1fe5b836695564cad98f40eb49e2addae1";
    hash = "sha256-UXsrWWjB5jvbxqfeVI7J2dAolnLAeL25zyAYe3VvsF8=";
  };

  cargoHash = "sha256-Brc4/lUJ27jCDaNWsyul6pEpllZ9yJnPewUwQBoXDoI=";

  buildInputs = [ ocl-icd ];

  meta = with lib; {
    description = "Generate a NANO address with a prefix of your choice";
    license = licenses.bsd2;
    maintainers = with maintainers; [ jyooru ];
  };
}
