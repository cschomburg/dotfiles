{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableGnomeExtensions = true;
      enableAdobeFlash = false;
    };

    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };

  environment.systemPackages = with pkgs; [
    attic
    chromium
    clawsMail
    deluge
    firefoxWrapper
    firejail
    gimp
    gitAndTools.gitRemoteGcrypt
    irssi
    libreoffice
    haskellPackages.git-annex-with-assistant
    keepassx2
    openjdk
    pidgin
    rxvt_unicode
    syncthing
    vlc
    xsel
  ];

  networking.firewall.allowedTCPPorts = [ 22000 ]; # syncthing

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
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

  services.dbus.packages = [ pkgs.gnome3.gconf ];
  environment.pathsToLink = [ "/etc/gconf" ];

  services.redshift = {
    enable = true;
    latitude = "52.5";
    longitude = "9.5";
  };

  nixpkgs.config.packageOverrides = pkgs: rec {
    rxvt_unicode = lib.overrideDerivation pkgs.rxvt_unicode (attrs: rec {
      desktopItem = pkgs.makeDesktopItem {
        name = "urxvt";
        exec = "urxvt";
        icon = "utilities-terminal";
        desktopName = "URxvt";
        genericName = "Terminal emulator";
      };

      postInstall = attrs.postInstall + ''
        mkdir -p $out/share/applications
        cp $desktopItem/share/applications/* $out/share/applications
      '';
    });
  };
}
