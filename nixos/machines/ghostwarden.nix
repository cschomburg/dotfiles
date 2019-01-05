{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../profiles/development.nix
      ../profiles/sync.nix
    ];

  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    beets
    ffmpeg
    isync
    python
    snapper
    vdirsyncer
  ];

  networking.firewall.enable = false;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.bluetooth.enable = true;

  services.openssh.startWhenNeeded = false;
  services.cron.enable = true;
  services.fail2ban.enable = true;
  services.fail2ban.jails.ssh-iptables = "enabled = true";

  services.syncthing.enable = true;
  services.syncthing.user = "xconstruct";
  services.syncthing.guiAddress = "0.0.0.0:8384";
  services.syncthing.configDir = "/var/lib/syncthing";

  services.plex.enable = true;
  services.plex.user = "xconstruct";
  networking.firewall.allowedTCPPorts = [ 32400 ];

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  services.postgresql.enable = true;

  users.extraGroups = { files.gid = 1001; };
  users.extraUsers.xconstruct.extraGroups = [ "lp" "files" "ssl-cert" ];
}
