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
    (import ../overlays/ansible-plugins.nix)
    (import ../overlays/fixes.nix)
    (import ../overlays/usbarmory.nix)
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes "];

  environment.systemPackages = with pkgs; [
    ansible-with-plugins
    age
    appimage-run
    dbeaver
    hledger
    haskellPackages.hledger-flow
    imx_loader
    isync
    insomnia
    ledger
    #mysql80.client

    (php82.withExtensions ({ enabled, all }:
      enabled ++ [ all.ffi all.redis all.xsl ])
    )
  ];

  environment.sessionVariables.LD_LIBRARY_PATH = [
    "${pkgs.libsecret}/lib"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];

  hardware.ledger.enable = true;
  hardware.opengl.driSupport32Bit = true;

  services.fprintd.enable = false;

  virtualisation.virtualbox.host = {
    enable = false;
    enableExtensionPack = true;
  };

  networking.firewall.allowedTCPPorts = [ 9000 ];

  nix.settings.max-jobs = lib.mkDefault 8;

  systemd.user = {
    timers.cleanup-downloads = {
      partOf = [ "cleanup-downloads.service" ];
      timerConfig.OnCalendar = "hourly";
    };
    services.cleanup-downloads = {
      serviceConfig.Type = "oneshot";
      script = ''
        find /home/xconstruct/Downloads -mtime +3 -type f -delete
        find /home/xconstruct/Downloads -type d -mindepth 1 -empty -delete
      '';
    };
  };
}
