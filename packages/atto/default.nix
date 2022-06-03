{ lib, buildGoModule, fetchFromGitHub, ocl-icd }:
buildGoModule rec {
  pname = "atto";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "codesoap";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-kqywB7Ai0lV7SaGoirdpSAXNytOr40WOXu31v9mpO5Y=";
  };

  vendorSha256 = "sha256-qeZbpcWVwk8GrLoYHbG5+tNPLAFjo0VydGMKXhhKw5s=";

  meta = with lib; {
    description = "Command line Nano wallet focusing on simplicity";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
