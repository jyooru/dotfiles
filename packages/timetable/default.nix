{ lib
, stdenv
, rustPlatform
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "0wvybrvdh1kipz925b4644df654p20wvgcjlg69wc7i5dll5pv73";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
