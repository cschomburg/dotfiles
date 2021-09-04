{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    cachix
    cmake
    curlie
    direnv
    ffmpeg
    fzf
    gcc
    gdb
    gnumake
    jq
    mtr
    openssl
    pandoc
    perl
    reflex
    shellcheck
    sqlite
    starship
    tealdeer

    # Python
    (python3.withPackages (ps: with ps; [
      ps.black
      ps.requests
      ps.pip
      ps.pylint
      # ps.python-language-server
    ]))

    # JavaScript
    deno
    nodejs-14_x
    yarn

    # Other programming languages
    go
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
    "vm.swappiness" = 1;
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
