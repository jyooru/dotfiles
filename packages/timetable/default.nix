{ lib
, stdenv
, rustPlatform
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "1wqrhjlkij2n55599lqmwfiwnw14h9qz82q0fwyridngnz03djv2";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
