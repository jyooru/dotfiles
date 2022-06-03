{ lib, buildGoModule, fetchFromGitHub, ocl-icd }:
buildGoModule rec {
  pname = "vanity-monero";
  version = "0.2.8";

  src = fetchFromGitHub {
    owner = "monero-ecosystem";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-tEYQk/GQADyRoWidKSnPQFCCbtZCvMaPF9ej9SQk6V4=";
  };

  vendorSha256 = "sha256-SzWED3M6MVxC4p64g512XVaO7JoHyO3aAgxnzHX9jO4=";

  meta = with lib; {
    description = "Monero vanity wallet generator";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
