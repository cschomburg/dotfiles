{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    borgbackup
    cryptsetup
    encfs
    gitAndTools.git-crypt
    gitAndTools.gitAnnex
    gitAndTools.gitRemoteGcrypt
    gocryptfs
    rclone
    unionfs-fuse
  ];

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 204800;
  };
}
