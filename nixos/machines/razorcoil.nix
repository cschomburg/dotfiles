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
  services.xserver.synaptics.enable = true;

  services.syncthing.enable = true;
  systemd.services.syncthing.serviceConfig = pkgs.lib.mkForce {
    User = "xconstruct";
    Group = "nogroup";
    PermissionsStartOnly = true;
    ExecStart = "${config.services.syncthing.package}/bin/syncthing -no-browser -home=${config.services.syncthing.dataDir}";
    Restart = "always";
  };

  services.samba = {
    enable = true;
    shares = {
      code =
        { path = "/home/xconstruct/code";
          "read only" = "no";
          browseable = "yes";
          "valid users" = "xconstruct";
        };
      default =
        { path = "/home/xconstruct/sync/default";
          "read only" = "no";
          browseable = "yes";
          "valid users" = "xconstruct";
        };
    };
  };
}
