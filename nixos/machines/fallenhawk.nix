{ config, pkgs, stdenv, ... }:

{
  imports =
    [
      ../profiles/vpn.nix
      ../profiles/seed.nix
      ../profiles/sync.nix
    ];

  environment.systemPackages = with pkgs; [
    irssi
    php
  ];

  services.openssh.startWhenNeeded = false;
  services.fail2ban.enable = true;
  services.fail2ban.jails.ssh-iptables = "enabled = true";

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  networking.enableIPv6 = false;

  services.cron.enable = true;
  services.plex.enable = true;
  services.plex.user = "seed";
  networking.firewall.allowedTCPPorts = [ 32400 ];

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  services.delugeMulti.instances = ["1" "2"];
  networking.firewall.allowedTCPPortRanges = [ { from = 58846; to = 58866; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 58846; to = 58866; } ];

  # OpenVPN traffic forwarding
  networking.firewall.extraCommands = ''
    iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o vethlxc2 -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.8.1.0/24 -o vethlxc2 -j MASQUERADE
    iptables -A INPUT -i tun+ -j ACCEPT
    iptables -A FORWARD -i tun+ -j ACCEPT
  '';
}
