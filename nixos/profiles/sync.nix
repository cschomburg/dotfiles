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

  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 204800;
  };

  services.syncthing = {
    enable = true;
    user = "xconstruct";
    group = "users";
    openDefaultPorts = true;

    declarative = {
      overrideFolders = false;
    };
  };
}
