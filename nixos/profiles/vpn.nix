{ config, lib, pkgs, ... }:

let ovpnConfig = ''
    dev tun

    ca /etc/openvpn/ca.crt
    cert /etc/openvpn/server.crt
    key /etc/openvpn/server.key
    dh /etc/openvpn/dh2048.pem

    push "redirect-gateway def1"
    push "dhcp-option DNS 8.8.8.8"

    cipher AES-256-CBC
    auth SHA256
    keepalive 10 120
    comp-lzo

    user nobody
    group nogroup
    persist-key
    persist-tun
    client-to-client
    duplicate-cn
  '';
in
{
  environment.systemPackages = with pkgs; [
    srelay
  ];

  services.openssh.enable = true;

  services.openvpn.servers.main = {
    config = ovpnConfig + ''
      port 636
      proto tcp
      server 10.8.0.0 255.255.255.0
	  push "route 10.8.1.0 255.255.255.0"
      ifconfig-pool-persist ipp-main.txt
    '';
  };
  services.openvpn.servers.udp = {
    config = ovpnConfig + ''
      port 1194
      proto udp
      server 10.8.1.0 255.255.255.0
	  push "route 10.8.0.0 255.255.255.0"
      ifconfig-pool-persist ipp-udp.txt
    '';
  };

  services.sslh.enable = true;
  services.sslh.settings = {
    protocols = [
      { name = "ssh"; service = "ssh"; host = "localhost"; port = "22"; }
      { name = "openvpn"; host = "localhost"; port = "636"; }
      { name = "http"; host = "localhost"; port = "80"; }
      { name = "tls"; host = "localhost"; port = "444"; }
      { name = "anyprot"; host = "localhost"; port = "444"; }
    ];
  };

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
