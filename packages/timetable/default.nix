{ lib
, python3Packages
}:

with python3Packages;

buildPythonPackage rec {
  pname = "timetable";
  version = "0.1.0";
  format = "pyproject";

  src = ./.;

  nativeBuildInputs = [ poetry-core ];

  propagatedBuildInputs = [ fuzzywuzzy rich ];

  pythonImportsCheck = [ "fuzzywuzzy" "rich" ];

  meta = with lib; {
    description = "Easily check your timetable from the terminal";
    license = licenses.mit;
    maintainers = with maintainers; [ jyooru ];
  };
}
