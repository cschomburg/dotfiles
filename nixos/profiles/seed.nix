{ config, lib, pkgs, stdenv, ... }:

with lib;

{
  imports = [ ../modules/deluge.nix ];

  nixpkgs.overlays = [
    (import ../overlays/irssi-autodl.nix)
  ];

  environment.systemPackages = with pkgs; [
    irssi-autodl
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
    { from = 6890;  to = 6999; }
    { from = 8112;  to = 8112; }
    { from = 58846; to = 58859; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 6890;  to = 6999; }
    { from = 58846; to = 58859;}
  ];

  services.deluge = {
    enable = true;
    package = pkgs.deluge-2_x;
    user = "seed";
    group = "seed";

    web.enable = true;
  };

  services.autobrr = {
    enable = true;
    secretFile = "/etc/autobrr-sessionsecret";
    settings = {
      host = "0.0.0.0";
    };
  };
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 7474 ];

  services.jellyfin = {
    enable = true;
    user = "seed";
    openFirewall = true;
  };
}
