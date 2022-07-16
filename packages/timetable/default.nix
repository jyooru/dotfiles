{ lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoHash = "sha256-lU2ppBTvWxrkFTl8k6w4ELNutRq7woKyDrMVG4PhTis=";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
