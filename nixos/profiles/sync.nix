{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    borgbackup
    cryptsetup
    encfs
    gitAndTools.git-crypt
    gitAndTools.gitAnnex
    gitAndTools.gitRemoteGcrypt
    rclone
    syncthing
    unionfs-fuse
  ];

  networking.firewall.allowedTCPPorts = [ 22000 ]; # syncthing
  networking.firewall.allowedUDPPorts = [ 21027 ]; # syncthing

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 204800;
  };
}
