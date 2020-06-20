with import <nixpkgs> { };
with stdenv.lib;
with pkgs.qt5;

stdenv.mkDerivation rec {
  pname = "sirikali";
  version = "1.4.4";

  src = fetchFromGitHub {
    owner = "mhogomchungu";
    repo = "sirikali";
    rev = version;
    sha256 = "0xsish3a5ai0cb8d6ac779kd8k4rwkkik6jk85d14j21pcq3f7r7";
  };

  nativeBuildInputs = [ cmake wrapQtAppsHook qttools ];

  buildInputs = [
    libgcrypt
    libpwquality
    libsecret
    pkg-config
    qtbase
  ];

  patches = [ ./add-current-system-path.patch ];

  postPatch = ''
    sed -i 's|"/usr/local/bin/"|"${gocryptfs}/bin/"|' src/engines.cpp
  '';

  meta = {
    description = "A Qt/C++ GUI front end to sshfs, ecryptfs-simple, cryfs, gocryptfs, securefs, fscrypt and encfs";
    homepage = "https://mhogomchungu.github.io/sirikali/";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
