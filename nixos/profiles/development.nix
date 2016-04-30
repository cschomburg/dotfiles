{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    cmake
    gdb
    gnumake
    mercurial
    neovim
    python
    #subversionClient
  ];
}
