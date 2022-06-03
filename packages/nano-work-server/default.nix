{ lib, rustPlatform, fetchFromGitHub, ocl-icd }:
rustPlatform.buildRustPackage rec {
  pname = "nano-work-server";
  version = "0.4.13";

  src = fetchFromGitHub {
    owner = "nanocurrency";
    repo = pname;
    rev = "44468bc511da1b77ce5328b581c5ce5f71806389";
    hash = "sha256-jM/OSoxwmnetyuyrHMpYCPZz/o0k9ko8X5RKpXQLJjU=";
  };

  cargoHash = "sha256-x3bMRtsJ6ybyORod9tsgL0SHOAGYtkdbAfoTB4cj7ko=";

  buildInputs = [ ocl-icd ];

  meta = with lib; {
    description = "A dedicated work server for the Nano cryptocurrency";
    license = licenses.bsd2;
    maintainers = with maintainers; [ jyooru ];
  };
}
