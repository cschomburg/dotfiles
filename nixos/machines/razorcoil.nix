{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/scientific.nix
      ../profiles/sync.nix
    ];

  environment.systemPackages = with pkgs; [
    electrum
    gnucash
  ];

  #networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.firewall.enable = false;

  services.timesyncd.enable = true;

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
}
