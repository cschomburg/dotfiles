{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/development.nix
      ../profiles/sync.nix
    ];

  boot.cleanTmpDir = true;

  environment.systemPackages = with pkgs; [
    #haskellPackages.buchhaltung
    hledger
    ledger
    php
  ];

  networking.firewall.enable = false;

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.syncthing.guiAddress = "0.0.0.0:8384";

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
}
