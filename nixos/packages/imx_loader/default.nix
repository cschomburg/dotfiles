{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with pkgs.stdenv.lib;

stdenv.mkDerivation rec {
  pname = "imx_loader";
  version = "20200104";

  src = fetchFromGitHub {
    owner = "boundarydevices";
    repo = "imx_usb_loader";
    rev = "f009770d841468204ab104bf7d3b0c5bc8425dbb";
    sha256 = "14yf9kfxrg3pxs6pwhds7z2mn78mch8nyk21myalr3m55bxkif9k";
  };

  buildInputs = [
    libusb1
    pkgconfig
  ];

  makeFlags = [ "prefix=$(out)" ];
}
