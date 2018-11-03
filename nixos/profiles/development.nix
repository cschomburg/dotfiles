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
  ];

  nixpkgs.config.php.xsl = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
    "vm.swappiness" = 1;
  };
}
