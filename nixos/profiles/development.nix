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

  virtualisation.virtualbox.host.enable = true;
}
