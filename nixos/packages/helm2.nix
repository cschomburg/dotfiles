{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with pkgs.lib;

stdenv.mkDerivation rec {
  owner = "helm";
  repo = "helm";
  version = "2.16.3";

  pname = "helm2";
  sha256 = "14yf9kfxrg3pxs7pwhds7z2mn78mch8nyk21myalr3m55bxkif9k";

  phases = [ "unpackPhase" "installPhase" ];

  src = fetchurl {
    url = "https://get.helm.sh/helm-v${version}-linux-amd64.tar.gz";
    sha256 = "0vh8gd1fdpc0pfs82dw0s7clwj8gg8sr0h90xpnyhw38dmrfny4n";
  };

  installPhase = ''
    mkdir -p "$out/bin"
    mv helm "$out/bin/helm2"
  '';
}
