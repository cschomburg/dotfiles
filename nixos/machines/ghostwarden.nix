{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../profiles/music.nix
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

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  services.postgresql.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", KERNEL=="hci0", RUN+="${lib.getBin pkgs.bluez5}/bin/hciconfig hci0 up"
  '';

  services.mpd = {
    enable = true;
    group = "files";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "My Pulse Output"
        server "127.0.0.1"
      }
    '';
  };
  systemd.services.mpdscribble = {
    description = "MPDScribble daemon";
    requires = [ "mpd.service" ];
    after = [ "mpd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.mpdscribble}/bin/mpdscribble --no-daemon --conf=/etc/mpdscribble.conf";
      User = "mpd";
    };
  };

  users.extraGroups = { files.gid = 1001; };
  users.extraUsers.xconstruct.extraGroups = [ "lp" "files" "ssl-cert" ];
}
