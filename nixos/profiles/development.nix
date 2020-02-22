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
    shellcheck
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
  networking.interfaces."lo".ipv4.addresses = [
    { address = "10.254.254.254"; prefixLength = 24; }
  ];

  environment.etc."php.d/php.ini".text = ''
    extension=${pkgs.php74Packages.redis}/lib/php/extensions/redis.so
    extension=${pkgs.php74Packages.imagick}/lib/php/extensions/imagick.so
  '';
}
