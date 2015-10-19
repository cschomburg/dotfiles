{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
    ];

  services.xserver.synaptics.enable = true;
}
