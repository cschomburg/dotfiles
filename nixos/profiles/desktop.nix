{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      #jre = true;
      #enableGoogleTalkPlugin = true;
      enableAdobeFlash = false;
    };

    chromium = {
      #jre = true;
      #enableGoogleTalkPlugin = true;
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };

  environment.systemPackages = with pkgs; [
    chromium
    firefox
    firejail
    openjdk
    xsel
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      inconsolata
      ubuntu_font_family
    ];
  };

  security.setuidPrograms = [ "firejail" ];
  services.printing.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgrl-intl";
    xkbOptions = "eurosign:e";

    displayManager.gdm.enable = true;
	desktopManager.gnome3.enable = true;

    synaptics = {
      twoFingerScroll = true;
      maxSpeed = "1.75";
      accelFactor = "0.0615";
    };
  };

  services.redshift = {
    enable = true;
    latitude = "52.5";
    longitude = "9.5";
  };
}
