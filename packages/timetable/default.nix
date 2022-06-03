{ lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "timetable";
  version = "1.0.0";

  src = ./.;

  cargoHash = "sha256-1MMHn5/gNkHzEvs1YlkG5nbPJswpApC8QKJYy0g/NyU=";

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
