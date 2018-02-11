{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/development.nix
      ../profiles/scientific.nix
      ../profiles/sync.nix
    ];

  environment.systemPackages = with pkgs; [
    ledger
    hledger
  ];

  #networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.firewall.enable = false;
  networking.extraHosts = ''
    127.0.0.1 pm.test
  '';

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
  virtualisation.docker.liveRestore = false;
}
