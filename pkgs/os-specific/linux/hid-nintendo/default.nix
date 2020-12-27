# References:
# - See `pkgs/os-specific/linux/xpadneo/default.nix`
# - Also see: https://nixos.wiki/wiki/Linux_kernel

{ lib, stdenv, fetchFromGitHub, kernel }:

stdenv.mkDerivation rec {
  pname = "hid-nintendo";
  version = "3.0";

  src = fetchFromGitHub {
    owner = "nicman23";
    repo = "dkms-hid-nintendo";
    rev = version;
    sha256 = "0wyiq4xv8qxw7iyyhnx47a3ygsgzc0ns08sa0fy1kj3ryarwizp2";
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/source/src
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];

  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = with stdenv.lib; {
    description = "A Nintendo HID kernel module";
    homepage = "https://github.com/nicman23/dkms-hid-nintendo";
    license = licenses.gpl2;
    maintainers = [ maintainers.rencire ];
    platforms = platforms.linux;
  };
}
