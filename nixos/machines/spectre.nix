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
    hledger
    imx_loader
    isync
    ledger
    mysql-client
    python3Packages.solo-python

    (php74.withExtensions
      (e: php74.enabledExtensions ++ [ e.imagick e.redis e.xsl ])
    )
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.v4l2loopback ];

  hardware.ledger.enable = true;
  hardware.u2f.enable = true;

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
        find /home/xconstruct/downloads -mtime +7 -type f -delete
        find /home/xconstruct/downloads -type d -empty -delete
      '';
    };
  };
}
