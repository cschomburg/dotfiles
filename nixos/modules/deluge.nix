{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.delugeMulti;

  initialDelugeConfig = i: pkgs.writeText "core.conf" ''
    { "file": "1", "format": "3" }{
      "allow_remote": true,
      "daemon_port": ${toString (builtins.add cfg.port i)},
      "listen_ports": [ ${toString cfg.ports.from}, ${toString cfg.ports.to} ]
    }
  '';

  mkDelugeJob = i: name:
    {
      description = "Deluge instance " + name;
      after = [ "deluged-initial-config" "network.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.deluge ];

      script = ''
        CONF=/home/${cfg.user}/.config/deluge-${name}
        if [ ! -e $CONF/core.conf ]; then
          mkdir -p $CONF
          cp ${initialDelugeConfig i} $CONF/core.conf
        fi
        exec ${pkgs.deluge}/bin/deluged -d -c $CONF
      '';
      serviceConfig = {
        Restart = "on-success";
        User = cfg.user;
        Group = cfg.group;
      };
    };

in
{
  options.services.delugeMulti = {
    port = mkOption {
      default = 58846;
      type = types.int;
    };
    ports = mkOption {
      default = {
        from =  58856;
        to = 58866;
      };
    };

    instances = mkOption {
      default = [];
      example = [ "main" "backup" ];
      type = types.listOf types.str;
    };

    user = mkOption {
      default = "deluge";
      type = types.str;
    };
    group = mkOption {
      default = "deluge";
      type = types.str;
    };
  };

  config = mkIf (cfg.instances != []) {
    environment.systemPackages = [ pkgs.deluge ];

    systemd.services = listToAttrs (lib.imap (i: name: nameValuePair ("deluged-" + name) (mkDelugeJob i name)) cfg.instances);

    users.extraUsers.deluge = mkIf (cfg.user == "deluge") {
      group = cfg.group;
      uid = config.ids.uids.deluge;
      home = "/var/lib/deluge/";
      createHome = true;
      description = "Deluge Daemon user";
    };

    users.extraGroups.deluge = mkIf (cfg.group == "deluge") config.ids.gids.deluge;
  };
}
