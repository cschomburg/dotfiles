{ config, lib, pkgs, stdenv, ... }:

with lib;

{
  imports = [ ../modules/deluge.nix ];

  environment.systemPackages = with pkgs; [
    irssi
    mktorrent
    rtorrent

    # autodl
    perlPackages.ArchiveZip
    perlPackages.NetSSLeay
    perlPackages.XMLLibXML
    perlPackages.HTMLParser
    perlPackages.JSON
    perlPackages.JSONXS
    DigestSHA
  ];

  users.extraUsers.seed = {
    group = "seed";
    createHome = true;
    home = "/home/seed";
    isNormalUser = true;
  };
  users.extraGroups.seed = { };

  networking.firewall.allowedTCPPortRanges = [ { from = 58846; to = 58859; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 58846; to = 58859; } ];

  services.delugeMulti = {
    user = "seed";
    group = "seed";
  };

  #systemd.services."autodl-irssi" = {
  #  description = "Autostart autodl-irssi";
  #  wantedBy = [ "multi-user.target" ];
  #  wants = [ "network-online.target" ];
  #  path = [ pkgs.irssi ];
  #  serviceConfig = {
  #    ExecStart = "${pkgs.tmux}/bin/tmux -v new-session -s autodl -d ${pkgs.irssi}/bin/irssi";
  #    ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t autodl";
  #    User = "seed";
  #    Type = "oneshot";
  #    RemainAfterExit = true;
  #  };
  #};

  nixpkgs.config.packageOverrides = pkgs: rec {
    DigestSHA = pkgs.buildPerlPackage rec {
      name = "Digest-SHA-5.95";
      src = pkgs.fetchurl {
        url = "mirror://cpan/authors/id/M/MS/MSHELOR/${name}.tar.gz";
        sha256 = "c7573f0f3b2bc280f8567c76eb2422ee8da19af5a5fa75988dc47e14de2e1471";
      };
      meta = {
        description = "Perl extension for SHA-1/224/256/384/512";
        license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
      };
    };

    deluge = pkgs.deluge.override {
      propagatedBuildInputs = with pkgs.pythonPackages; [
        pyGtkGlade libtorrentRasterbar_1_0_9 twisted Mako chardet pyxdg pyopenssl service-identity
      ];
    };

    libtorrentRasterbar_1_0_9 = pkgs.callPackage <nixpkgs/pkgs/development/libraries/libtorrent-rasterbar/generic.nix> {
      version = "1.0.9";
      sha256 = "1kfydlvmx4pgi5lpbhqr4p3jr78p3f61ic32046mkp4yfyydrspl";
    };
  };
}
