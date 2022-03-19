{ lib
, stdenv
, rustPlatform
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoSha256 = "14ya63hb6vrn09ygkwf7m2bi6raid8v40fcg4pf83p9grrrlpp0f";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
