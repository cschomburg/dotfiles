{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    mpc_cli
    mpd
    mpdscribble
    ncmpcpp
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; };
  };
}
