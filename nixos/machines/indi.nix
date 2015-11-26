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

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];

  virtualisation.virtualbox.host.enable = true;
}

