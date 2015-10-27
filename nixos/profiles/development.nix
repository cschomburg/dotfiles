{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cmake
    gdb
    gnumake
    mercurial
    neovim
    python
    subversionClient
    vagrant
  ];

  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];

  virtualisation.virtualbox.host.enable = true;
}
