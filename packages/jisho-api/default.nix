{ lib
, python3
, fetchFromGitHub
}:

with python3.pkgs;

buildPythonPackage rec {
  pname = "jisho-api";
  version = "0.1.8";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "pedroallenrevez";
    repo = pname;
    rev = version;
    sha256 = "1xz8g07s0a1qhnd0vkvhqbrylb3a49bjxi7rwrlwqyhpz6pj30fy";
  };

  patches = [
    ./remove-bs4-dummy-package.patch
    ./rich-version.patch
  ];

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [
    click
    pydantic
    requests
    rich
  ];

  pythonImportsCheck = [ "jisho_api" ];

  meta = with lib; {
    description = " A jisho.org API made in Python";
    homepage = "https://github.com/pedroallenrevez/jisho-api";
    license = licenses.asl20;
    maintainers = with maintainers; [ jyooru ];
  };
}
