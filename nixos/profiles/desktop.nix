{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      # enableGnomeExtensions = true;
      enableAdobeFlash = false;
    };

    # chromium = {
    #   enablePepperFlash = true;
    #   enablePepperPDF = true;
    # };
  };

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    deluge
    firefox-devedition-bin
    gimp
    libreoffice
    keepass
    vlc
    veracrypt
  ];

  nixpkgs.overlays = [
    (self: super: {
      keepass = super.keepass.override {
        plugins = [ self.keepass-keepassrpc ];
      };
    })
  ];

  # boot.supportedFilesystems = [ "ntfs-3g" ];

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
      roboto
    ];
  };

  # security.pam.enableEcryptfs = true;
  # security.wrappers.firejail.source = "${pkgs.firejail.out}/bin/firejail";
  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "eurosign:e";

    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome3.enable = true;

    #displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  services.xserver.libinput = {
    enable = true;
  };

  # services.redshift = {
  #   enable = true;
  #   latitude = "52.5";
  #   longitude = "9.5";
  # };
}
