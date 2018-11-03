{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/development.nix
      ../profiles/scientific.nix
      ../profiles/sync.nix
    ];

  boot.cleanTmpDir = true;

  environment.systemPackages = with pkgs; [
    #haskellPackages.buchhaltung
    hledger
    ledger
  ];

  #networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.firewall.enable = false;

  services.timesyncd.enable = true;
  services.zerotierone.enable = true;

  services.syncthing.enable = true;
  services.syncthing.user = "xconstruct";

  services.samba = {
    enable = true;
    shares = {
      home =
        { path = "/home/xconstruct";
          "read only" = "no";
          browseable = "yes";
          "valid users" = "xconstruct";
        };
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";
  virtualisation.docker.liveRestore = false;
}
