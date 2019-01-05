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
}
