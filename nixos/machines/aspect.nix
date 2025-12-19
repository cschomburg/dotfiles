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
  boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = "1";
  };

  # qemu-guest
  boot.initrd.availableKernelModules = [ "virtio_net" "virtio_pci" "virtio_mmio" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ];
  boot.initrd.kernelModules = [ "virtio_balloon" "virtio_console" "virtio_rng" "virtio_gpu" ];

  networking.useDHCP = false;
  nixpkgs.config.allowUnfree = true;

  services.fail2ban.enable = true;
  services.openssh.enable = true;
  services.cron.enable = true;
  services.jellyfin = {
    enable = true;
    user = "seed";
    openFirewall = true;
  };

  services.tailscale.enable = true;

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    #recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  system.stateVersion = "20.03"; # Did you read the comment?

  nix.settings.max-jobs = lib.mkDefault 4;
  nix.settings.experimental-features = "nix-command flakes";
}
