{ lib
, stdenv
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "1w33dl78rsbnrpbjb9hfblizq2hlp5q8bwzvxif6g59i00nbdmrs";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
