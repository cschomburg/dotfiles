{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/music.nix
      ../profiles/scientific.nix
    ];

  environment.systemPackages = with pkgs; [
    calibre
    electrum
    gnucash
    speedcrunch
  ];

  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];

  virtualisation.virtualbox.host.enable = true;
}

