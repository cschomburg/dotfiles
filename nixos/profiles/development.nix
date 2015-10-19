{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cmake
    gdb
    mercurial
    neovim
    subversionClient
    vagrant
  ];

  virtualisation.virtualbox.host.enable = true;
}
