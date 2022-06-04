{ lib, buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "vanieth";
  version = "2021-11-17";

  src = fetchFromGitHub {
    owner = "makevoid";
    repo = pname;
    rev = "e13ba4a78b4794b1af2215582098520d571727ba";
    hash = "sha256-ezTyslZIx+HiJ4kEJpZkpmrJbkVfDWleAB1FbvJ1b8U=";
  };

  vendorSha256 = "sha256-GImUEIovRKO19YCvhQt3oQYuFxwOSwnxgRZf5X9PW+g=";

  meta = with lib; {
    description = "Ethereum vanity address generator";
    maintainers = with maintainers; [ jyooru ];
  };
}
