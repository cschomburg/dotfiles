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
    kde4.kdeconnect
    openjdk
    pidgin
    rxvt_unicode
    syncthing
    vlc
    xsel
  ];

  boot.cleanTmpDir = true;

  networking.firewall.allowedTCPPorts = [ 22000 ]; # syncthing
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
    ];
  };

  security.pam.enableEcryptfs = true;
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
  environment.gnome3.packageSet = pkgs.gnome3_18;

  services.dbus.packages = [ config.environment.gnome3.packageSet.gconf ];
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
