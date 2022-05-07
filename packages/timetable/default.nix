{ lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "099p7x4cnn5282y900i9rhkcyxp60rcn4dgv2brl2dp0kyghghyl";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
