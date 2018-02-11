{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableGnomeExtensions = true;
      enableAdobeFlash = false;
    };

    # chromium = {
    #   enablePepperFlash = true;
    #   enablePepperPDF = true;
    # };
  };

  environment.systemPackages = with pkgs; [
    chromium
    clawsMail
    deluge
    #firefox-developer-bin
    firejail
    gimp
    irssi
    libreoffice
    keepassx2
    openjdk
    pidgin
    rxvt_unicode
    vlc
    xsel
    youtube-dl
  ];

  boot.cleanTmpDir = true;
  boot.supportedFilesystems = [ "ntfs-3g" ];

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

  security.pam.enableEcryptfs = true;
  security.wrappers.firejail.source = "${pkgs.firejail.out}/bin/firejail";
  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgrl-intl";
    xkbOptions = "eurosign:e";

    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
  };

  services.dbus.packages = [ config.environment.gnome3.packageSet.gconf ];
  environment.pathsToLink = [ "/etc/gconf" ];

  services.redshift = {
    enable = true;
    latitude = "52.5";
    longitude = "9.5";
  };
}
