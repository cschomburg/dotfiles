{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  ];

  services.openssh.enable = true;

  services.openvpn.servers.main = {
    config = ''
      port 636
      proto tcp
      dev tun

      ca /etc/openvpn/ca.crt
      cert /etc/openvpn/server.crt
      key /etc/openvpn/server.key
      dh /etc/openvpn/dh2048.pem

      server 10.8.0.0 255.255.255.0
      ifconfig-pool-persist ipp.txt
      push "redirect-gateway def1"
      push "dhcp-option DNS 8.8.8.8"
      push "dhcp-option DNS 8.8.4.4"

      cipher AES-256-CBC
      auth SHA256
      keepalive 10 120
      comp-lzo

      user nobody
      group nogroup
      persist-key
      persist-tun
    '';
  };

  services.sslh.enable = true;
  services.sslh.host = "0.0.0.0";
  services.sslh.appendConfig = ''
    protocols:
    (
      { name: "ssh"; service: "ssh"; host: "localhost"; port: "22"; probe: "builtin"; },
      { name: "openvpn"; host: "localhost"; port: "636"; probe: "builtin"; },
      { name: "http"; host: "localhost"; port: "80"; probe: "builtin"; },
      { name: "ssl"; host: "localhost"; port: "444"; probe: "builtin"; },
      { name: "anyprot"; host: "localhost"; port: "444"; probe: "builtin"; }
    );
  '';

  networking.firewall.allowedTCPPorts = [ 636 443 ];

  users.extraUsers.forward = {
    createHome = true;
    description = "SSH Forwarding User";
    isNormalUser = true;
  };

  systemd.services."forward_keygen" = {
    description = "Setup keyfiles for forwarding user";
    wantedBy = [ "multi-user.target" ];
    after = [ "sshd.service" ];
    script = ''
      if [ ! -e /home/forward/.ssh/id_rsa ]; then
        ${pkgs.openssh}/bin/ssh-keygen -t rsa -N "" -f /home/forward/.ssh/id_rsa
      fi
    '';
    serviceConfig = {
      User = "forward";
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
