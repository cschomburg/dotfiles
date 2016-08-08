{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    borgbackup
    cryptsetup
    encfs
    gitAndTools.git-crypt
    gitAndTools.gitRemoteGcrypt
    gitAndTools.gitAnnex
    syncthing
  ];

  networking.firewall.allowedTCPPorts = [ 22000 ]; # syncthing
  networking.firewall.allowedUDPPorts = [ 21027 ]; # syncthing
}
