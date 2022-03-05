{ lib
, stdenv
, rustPlatform
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "1qi1c09xrhgbfzanafradv86ar0ws41d4nvb0xb780a4yafjbg4s";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
