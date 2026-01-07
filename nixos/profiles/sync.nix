{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    borgbackup
    cryptsetup
    git-crypt
    git-annex
    git-remote-gcrypt
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
