{ lib, rustPlatform, fetchFromGitHub, ocl-icd }:
rustPlatform.buildRustPackage rec {
  pname = "nakatoshi";
  version = "0.2.8";

  src = fetchFromGitHub {
    owner = "ndelvalle";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-h20R5DY5cAQyqC4xnYOsUVM6WjDLxV7Xhys3igWL7w0=";
  };

  cargoHash = "sha256-VAEcQ4TGPnwCq3Zjv/8DclyK/mHIAo4wr2XtpT6nD/0=";

  meta = with lib; {
    description = "Bitcoin vanity address generator";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
