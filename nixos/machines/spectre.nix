{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../profiles/desktop.nix
      ../profiles/development.nix
      ../profiles/devops.nix
      ../profiles/laptop.nix
      ../profiles/sync.nix
    ];

  nixpkgs.overlays = [
    (import ../overlays/neovim-nightly.nix)
    (import ../overlays/usbarmory.nix)
  ];

  environment.systemPackages = with pkgs; [
    age
    dbeaver
    go-jira
    hledger
    haskellPackages.hledger-flow
    imx_loader
    isync
    insomnia
    ledger
    mysql-client
    python3Packages.solo-python

    (php74.withExtensions ({ enabled, all }:
      enabled ++ [ all.imagick all.redis all.xsl ])
    )
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];

  hardware.ledger.enable = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;

  virtualisation.virtualbox.host = {
    enable = false;
    enableExtensionPack = true;
  };

  networking.firewall.allowedTCPPorts = [ 9000 ];

  nix.maxJobs = lib.mkDefault 8;

  systemd.user = {
    timers.cleanup-downloads = {
      partOf = [ "cleanup-downloads.service" ];
      timerConfig.OnCalendar = "hourly";
    };
    services.cleanup-downloads = {
      serviceConfig.Type = "oneshot";
      script = ''
        find /home/xconstruct/Downloads -mtime +3 -type f -delete
        find /home/xconstruct/Downloads -type d -empty -delete
      '';
    };
  };
}
