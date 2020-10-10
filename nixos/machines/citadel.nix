{ config, pkgs, ... }:

{
  imports =
    [
    ];

  environment.systemPackages = with pkgs; [
    cryptsetup
  ];

  virtualisation.libvirtd.enable = true;
}
