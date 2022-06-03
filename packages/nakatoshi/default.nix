{ lib, rustPlatform, fetchFromGitHub, ocl-icd }:
rustPlatform.buildRustPackage rec {
  pname = "nakatoshi";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "ndelvalle";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-ytjWcJNQ5Eecm475KGT/ShaH7HvZpF47nTQwG7eJP/Y=";
  };

  cargoHash = "sha256-yocRTrGsdDXNz/LHPB4o7EfFF5ANsNDhCysOU6Lm654=";

  meta = with lib; {
    description = "Bitcoin vanity address generator";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
