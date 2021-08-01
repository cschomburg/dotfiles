# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
      ../profiles/development.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
  boot.kernelModules = ["br_netfilter"];

  environment.systemPackages = with pkgs; [
    deno
    k3s
    kubectl
  ];

  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
  networking.firewall.allowedTCPPorts = [ 443 6443 ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.03"; # Did you read the comment?
  services.zerotierone.enable = true;
  services.openssh.enable = true;
  services.k3s.enable = true;

  nix.maxJobs = lib.mkDefault 4;
}
