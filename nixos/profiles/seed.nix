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
    DigestSHA

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

    # deluge = let
    #   packageOverrides = self: super: {
    #     pyopenssl = super.pyopenssl.overrideDerivation (attrs: rec {
    #       name = "pyopenssl-${version}";
    #       version = "16.2.0";
    #       src = pkgs.fetchurl {
    #         url = "mirror://pypi/p/pyOpenSSL/pyOpenSSL-${version}.tar.gz";
    #         sha256 = "0vji4yrfshs15xpczbhzhasnjrwcarsqg87n98ixnyafnyxs6ybp";
    #       };
    #     });
    #   };
    # in (pkgs.python.override {inherit packageOverrides;}).pkgs.deluge;

    # pythonPackages = pkgs.pythonPackages.override (attrs: {
    #   self = pythonPackages;
    # }) // {
    #   pyopenssl = pkgs.pythonPackages.pyopenssl.overrideDerivation (attrs: rec {
    #     name = "pyopenssl-${version}";
    #     version = "16.2.0";
    #     src = pkgs.fetchurl {
    #       url = "mirror://pypi/p/pyOpenSSL/pyOpenSSL-${version}.tar.gz";
    #       sha256 = "0vji4yrfshs15xpczbhzhasnjrwcarsqg87n98ixnyafnyxs6ybq";
    #     };
    #   });
    # };

    #    deluge = pkgs.deluge.override {
    #      propagatedBuildInputs = with pkgs.pythonPackages; [
    #        pyGtkGlade pkgs.libtorrentRasterbar_1_0 twisted Mako chardet pyxdg pyopenssl_16_2 service-identity
    #      ];
    #    };
    #
    #    pyopenssl_16_2 = pkgs.pythonPackages.pyopenssl.overrideDerivation (attrs: rec {
    #      name = "pyopenssl-${version}";
    #      version = "16.2.0";
    #      src = pkgs.fetchurl {
    #        url = "mirror://pypi/p/pyOpenSSL/pyOpenSSL-${version}.tar.gz";
    #        sha256 = "0vji4yrfshs15xpczbhzhasnjrwcarsqg87n98ixnyafnyxs6ybp";
    #      };
    #    });
  };
}
