{ lib, rustPlatform, fetchFromGitHub, ocl-icd }:
rustPlatform.buildRustPackage rec {
  pname = "nano-work-server";
  version = "0.4.13";

  src = fetchFromGitHub {
    owner = "nanocurrency";
    repo = pname;
    rev = "44468bc511da1b77ce5328b581c5ce5f71806389";
    sha256 = "0d961dsaajllbwy4mxi4ipz77xh8b351razcranpg6khii5cxkwc";
  };

  cargoSha256 = "0jpf4f3hf4zs05dlgdlq04w8fi1g43dzc78s77r2dsq9vd3cqxn7";

  buildInputs = [ ocl-icd ];

  meta = with lib; {
    description = "A dedicated work server for the Nano cryptocurrency";
    license = licenses.bsd2;
    maintainers = with maintainers; [ jyooru ];
  };
}
