# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    ../profiles/seed.nix
    ../profiles/sync.nix
    ../profiles/vpn.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = "1";
  };

  networking.useDHCP = false;
  nixpkgs.config.allowUnfree = true;

  services.fail2ban.enable = true;
  services.zerotierone.enable = true;
  services.openssh.enable = true;
  services.cron.enable = true;
  services.plex = {
    enable = true;
    user = "seed";
    openFirewall = false;
  };
  networking.firewall.allowedTCPPorts = [ 32400 ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    #recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  system.stateVersion = "20.03"; # Did you read the comment?

  nix.maxJobs = lib.mkDefault 4;
}
