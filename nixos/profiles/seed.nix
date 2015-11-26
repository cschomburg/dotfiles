{ config, lib, pkgs, ... }:

with lib;
{
  environment.systemPackages = with pkgs; [
    irssi
    mktorrent
    rtorrent
  ];

  users.extraUsers.seed = {
    group = "seed";
    createHome = true;
    home = "/home/seed";
  };
  users.extraGroups.seed = { };

  services.deluge.enable = true;
  networking.firewall.allowedTCPPortRanges = [ { from = 58846; to = 588859; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 58846; to = 588859; } ];
  systemd.services.deluged.serviceConfig.User = mkForce "seed";
  systemd.services.deluged.serviceConfig.Group = mkForce "seed";
}

