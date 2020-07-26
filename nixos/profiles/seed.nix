{ config, lib, pkgs, stdenv, ... }:

with lib;

{
  imports = [ ../modules/deluge.nix ];

  environment.systemPackages = with pkgs; [
    irssi
    perlPackages.ArchiveZip
    perlPackages.NetSSLeay
    perlPackages.XMLLibXML
    perlPackages.HTMLParser
    perlPackages.JSON
    perlPackages.JSONXS
    perlPackages.DigestSHA1

    mktorrent
  ];

  users.extraUsers.seed = {
    group = "seed";
    createHome = true;
    home = "/home/seed";
    isNormalUser = true;
  };
  users.extraGroups.seed = { };

  networking.firewall.allowedTCPPortRanges = [
    { from = 6890;  to = 6999;  }
    { from = 58846; to = 58859; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 6890;  to = 6999;  }
    { from = 58846; to = 58859; }
  ];

  services.deluge = {
    enable = true;
    package = pkgs.deluge-2_x;
    user = "seed";
    group = "seed";
  };

  # nixpkgs.config.packageOverrides = pkgs: rec {
  #   DigestSHA = pkgs.buildPerlPackage rec {
  #     name = "Digest-SHA-5.95";
  #     src = pkgs.fetchurl {
  #       url = "mirror://cpan/authors/id/M/MS/MSHELOR/${name}.tar.gz";
  #       sha256 = "c7573f0f3b2bc280f8567c76eb2422ee8da19af5a5fa75988dc47e14de2e1471";
  #     };
  #     meta = {
  #       description = "Perl extension for SHA-1/224/256/384/512";
  #       license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
  #     };
  #   };
  # };
}
