{ config, pkgs, stdenv, ... }:

{
  imports =
    [
      ../profiles/vpn.nix
      ../profiles/seed.nix
    ];

  environment.systemPackages = with pkgs; [
    irssi
  ];

  services.openssh.startWhenNeeded = false;
  services.fail2ban.enable = true;
  services.fail2ban.jails.ssh-iptables = "enabled = true";

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  networking.enableIPv6 = false;

  # OpenVPN traffic forwarding
  networking.firewall.extraCommands = ''
    iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o vethlxc2 -j MASQUERADE
    iptables -t nat -A POSTROUTING -s 10.8.1.0/24 -o vethlxc2 -j MASQUERADE
    iptables -A INPUT -i tun+ -j ACCEPT
    iptables -A FORWARD -i tun+ -j ACCEPT
  '';
}
