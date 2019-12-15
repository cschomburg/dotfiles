{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    cmake
    fzf
    gdb
    gnumake
    jq
    mercurial
    mtr
    neovim
    pandoc
    python
    reflex
    starship

    (python3.withPackages (ps: with ps; [
      ps.requests
    ]))
  ];

  nixpkgs.config.php.xsl = true;
  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
    "vm.swappiness" = 1;
  };

  nixpkgs.config.packageOverrides = pkgs: rec {
    neovim = pkgs.neovim.override {
      vimAlias = true;
      viAlias = true;
    };
  };

  networking.nat.internalInterfaces = [ "ve-+" ];
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";
  virtualisation.docker.liveRestore = false;

  environment.etc."php.d/php.ini".text = ''
    extension=${pkgs.phpPackages.redis}/lib/php/extensions/redis.so
    extension=${pkgs.phpPackages.imagick}/lib/php/extensions/imagick.so
  '';
}
