{ config, pkgs, ... }:

{
  imports =
    [
    ];

  environment.systemPackages = with pkgs; [
    cryptsetup
  ];

  services.fail2ban.enable = true;

  virtualisation.libvirtd.enable = true;
}
