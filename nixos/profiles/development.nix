{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind-tools
    cmake
    gdb
    gnumake
    mercurial
    neovim
    python
    subversionClient
  ];
}
