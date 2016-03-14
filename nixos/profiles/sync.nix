{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    attic
    borgbackup
    cryptsetup
    encfs
    gitAndTools.git-crypt
    gitAndTools.gitRemoteGcrypt
    haskellPackages.git-annex-with-assistant
    syncthing
  ];

  networking.firewall.allowedTCPPorts = [ 22000 ]; # syncthing
  networking.firewall.allowedUDPPorts = [ 21027 ]; # syncthing
}
