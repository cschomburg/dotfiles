{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/sync.nix
    ];

  nixpkgs.overlays = [
    (import ../overlays/ledger-udev-rules.nix)
  ];

  environment.systemPackages = with pkgs; [
    dbeaver
    hledger
    kube3d
    kubectl
    ledger
    php
    mysql-client
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ ];

  hardware.firmware = [ pkgs.firmwareLinuxNonfree ];
  hardware.bluetooth.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
  '';

  services.udev.packages = with pkgs; [
    ledger-udev-rules
  ];

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  nix.maxJobs = lib.mkDefault 8;
  #powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.cpuFreqGovernor =
    lib.mkIf config.services.tlp.enable (lib.mkForce null);
}
