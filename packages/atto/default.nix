{ lib
, buildGoModule
, fetchFromGitHub
, ocl-icd
}:
buildGoModule rec {
  pname = "atto";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "codesoap";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-8W6I5c8VHmdCY912CAJTMI1SFSJdkCAmMHX8QrLZmiM=";
  };

  vendorSha256 = "sha256-XkQM3Rcl1yp79fw+Cepp8JuXxVlZ6g3QGocLx8ejWXQ=";

  meta = with lib; {
    description = "Command line Nano wallet focusing on simplicity";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
