{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/sync.nix
    ];

  nixpkgs.overlays = [
    (import ../overlays/neovim-nightly.nix)
    (import ../overlays/usbarmory.nix)
  ];

  environment.systemPackages = with pkgs; [
    age
    dbeaver
    hledger
    imx_loader
    isync
    kube3d
    kubectl
    ledger
    mysql-client
    php74
    python3Packages.solo-python
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
  hardware.ledger.enable = true;
  hardware.u2f.enable = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
  '';

  virtualisation.virtualbox.host = {
    enable = false;
    enableExtensionPack = true;
  };

  networking.firewall.allowedTCPPorts = [ 9000 ];

  nix.maxJobs = lib.mkDefault 8;
  #powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.cpuFreqGovernor =
    lib.mkIf config.services.tlp.enable (lib.mkForce null);

  systemd.user = {
    timers.cleanup-downloads = {
      partOf = [ "cleanup-downloads.service" ];
      timerConfig.OnCalendar = "hourly";
    };
    services.cleanup-downloads = {
      serviceConfig.Type = "oneshot";
      script = ''
        find /home/xconstruct/downloads -mtime +7 -type f -delete
        find /home/xconstruct/downloads -type d -empty -delete
      '';
    };
  };
}
