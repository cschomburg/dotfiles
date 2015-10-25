{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/music.nix
    ];

    environment.systemPackages = with pkgs; [ gnucash ];
}

