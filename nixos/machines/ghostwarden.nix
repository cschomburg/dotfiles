{ config, pkgs, lib, ... }:

let
  privateIp = "10.147.17.1";
in {
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
  ];

  networking.firewall.enable = false;

  services.openssh.startWhenNeeded = false;
  services.cron.enable = true;
  services.fail2ban.enable = true;
  services.fail2ban.jails.ssh-iptables = "enabled = true";

  services.syncthing = {
    enable = true;
    user = "xconstruct";
    guiAddress = "0.0.0.0:8384";
    configDir = "/var/lib/syncthing";
    openDefaultPorts = true;
  };

  services.plex.enable = true;
  services.plex.user = "xconstruct";
  networking.firewall.allowedTCPPorts = [ 32400 ];

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  services.postgresql.enable = true;

  services.elasticsearch.enable = true;
  services.elasticsearch.listenAddress = privateIp;
  services.kibana.enable = true;
  services.kibana.listenAddress = privateIp;
  services.kibana.elasticsearch.hosts = [ "http://${privateIp}:9200" ];

  services.rabbitmq = {
    enable = true;
    configItems = {
      "listeners.tcp.1" = "${privateIp}:5672";
    };
  };

  users.extraGroups = { files.gid = 1001; };
  users.extraUsers.xconstruct.extraGroups = [ "lp" "files" "ssl-cert" ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
}
