{ fetchFromGitHub
, lib
, mkDerivation
, cmake
, extra-cmake-modules
, qtbase
, qttools
, kauth
, hicolor-icon-theme
, libaio
, fio
}:

mkDerivation rec {
  pname = "KDiskMark";
  version = "2.2.0";
  src = fetchFromGitHub {
    owner = "JonMagon";
    repo = "KDiskMark";
    rev = version;
    sha256 = "0hbkvi7vws85vw4k34kmar4nbkkl2ki7qkzc554vh43rk4xk9xg3";
  };
  buildInputs = [
    fio
    hicolor-icon-theme
    kauth
    qtbase
    libaio
  ];
  nativeBuildInputs = [
    extra-cmake-modules
    qttools
    cmake
  ];
  meta = with lib; {
    description = "";
    homepage = "https://github.com/JonMagon/KDiskMark";
    license = licenses.gpl3;
    maintainers = [ maintainers.rencire ];
    platforms = platforms.linux;
  };
}
