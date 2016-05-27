{ config, lib, pkgs, stdenv, ... }:

with lib; let
  initialDelugeConfig = pkgs.writeText "core.conf" ''
    { "file": "1", "format": "3" }{
      "allow_remote": true,
      "autoadd_location": "/home/seed/watch",
      "listen_ports": [ 58850, 58859 ]
    }
  '';

in
{
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

  services.deluge.enable = true;
  networking.firewall.allowedTCPPortRanges = [ { from = 58846; to = 58859; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 58846; to = 58859; } ];
  systemd.services.deluged.serviceConfig.User = mkForce "seed";
  systemd.services.deluged.serviceConfig.Group = mkForce "seed";

  systemd.services."deluged-initial-config" = {
    description = "Create initial Deluge config";
    wantedBy = [ "multi-user.target" ];
    before = [ "deluged.service" ];
    script = ''
      CONF=/home/seed/.config/deluge
      if [ ! -e $CONF/core.conf ]; then
        mkdir -p $CONF
        cp ${initialDelugeConfig}  $CONF/core.conf
      fi
    '';
    serviceConfig = {
      User = "seed";
      Type = "oneshot";
      RemainAfterExit = true;
    };
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
  };
}
