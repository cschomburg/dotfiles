{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    cmake
    fzf
    gdb
    gnumake
    mercurial
    neovim
    python
    httpie
    #subversionClient
  ];

  nixpkgs.config.php.xsl = true;
}
