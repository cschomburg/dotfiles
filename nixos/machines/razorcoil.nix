{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/sync.nix
    ];

  #networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.firewall.enable = false;

  services.timesyncd.enable = true;
  services.xserver.synaptics.enable = true;

  services.syncthing.enable = true;
  services.syncthing.user = "xconstruct";

  services.samba = {
    enable = true;
    shares = {
      code =
        { path = "/home/xconstruct/code";
          "read only" = "no";
          browseable = "yes";
          "valid users" = "xconstruct";
        };
    };
  };
}
