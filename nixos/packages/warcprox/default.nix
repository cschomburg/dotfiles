{ pkgs }:

let python = pkgs.callPackage ./requirements.nix { };
in python.packages.warcprox
