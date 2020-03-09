{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with pkgs.stdenv.lib;

buildGoPackage rec {
  pname = "rancher-cli";
  version = "2.3.2";

  src = fetchFromGitHub {
    owner = "rancher";
    repo = "cli";
    rev = "v${version}";
    sha256 = "0vans8rnarjax34zvivzc2i80y72261r931sfm09f3j91cp960c7";
  };

  goPackagePath = "github.com/rancher/cli";

  postInstall = ''
    mv $bin/bin/cli $bin/bin/rancher
  '';

  meta = {
    description = "The Rancher Command Line Interface (CLI) is a unified tool for interacting with your Rancher Server.";
    homepage = https://github.com/rancher/cli;
    license = lib.licenses.asl20;
    platforms = lib.platforms.unix;
  };
}
