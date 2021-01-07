{ mkDerivation
, fetchurl
, dpkg
, autoPatchelfHook
, SDL2
, qt514
, libglvnd
, gcc-unwrapped
, stdenv
}:

mkDerivation rec {
  name = "gamepad-tool";
  version = "1.2";

  src = fetchurl {
    url = "https://www.generalarcade.com/gamepadtool/linux/gamepadtool_${version}_amd64.deb";
    sha256 = "1kqglwb9a74nrxjsilvas3kgrwphzwfycs2dj581xn4kxi679q36";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    SDL2
    qt514.qtbase
    libglvnd
    gcc-unwrapped
  ];

  unpackCmd = "dpkg-deb -x $src .";

  sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    cp -R usr/ $out/

    # TODO fix path in debian desktop file
  '';

  meta = with stdenv.lib; {
    description = "A simple GUI tool to create/modify gamepad mappings for games that use SDL2 Game Controller API";
    homepage = https://www.generalarcade.com/gamepadtool/;
    license = licenses.unfree;
    maintainers = with stdenv.lib.maintainers; [ rencire ];
    platforms = [ "x86_64-linux" ];
  };
}


