{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with pkgs.stdenv.lib;

stdenv.mkDerivation rec {
  pname = "scangearmp2";
  version = "3.90";

  src = fetchurl {
    url = "http://gdlp01.c-wss.com/gds/7/0100010487/01/scangearmp2-source-${version}-1.tar.gz";
    sha256 = "10nnh31gkynx8bagygaxxsjxmrakyd35a2mha2d35gqh67z4z8gd";
  };

  NIX_LDFLAGS="-L../../com/libs_bin64";

  configurePhase = ''
    cd scangearmp2
    ./autogen.sh --prefix=$out --enable-libpath=$out/lib
  '';
  nativeBuildInputs = [
    autoconf
    automake
    file
    gcc
    gettext
    glib
    libtool
    pkgconfig
  ];

  buildInputs = [
    libusb1
    gtk2
    stdenv.cc.cc.lib
  ];

  makeFlags = [ "prefix=$(out)" ];

  postInstall = ''
    cp ../com/libs_bin64/* $out/lib/
  '';
}
