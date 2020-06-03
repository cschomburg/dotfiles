{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    cmake
    direnv
    ffmpeg
    fzf
    gdb
    gnumake
    jq
    mercurial
    mtr
    neovim
    pandoc
    reflex
    shellcheck
    starship

    # Python
    (python3.withPackages (ps: with ps; [
      ps.black
      ps.requests
      ps.pip
      ps.pylint
      ps.python-language-server
    ]))

    # JavaScript
    deno
    nodejs
    yarn

    # Other programming languages
    go
  ];

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

  services.lorri.enable = true;

  networking.nat.internalInterfaces = [ "ve-+" ];
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";
  virtualisation.docker.liveRestore = false;
  networking.interfaces."lo".ipv4.addresses = [
    { address = "10.254.254.254"; prefixLength = 24; }
  ];
}
