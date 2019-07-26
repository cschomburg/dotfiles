{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableGnomeExtensions = true;
    };
  };

  boot.cleanTmpDir = true;
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    deluge

    firefox-devedition-bin
    # (pkgs.wrapFirefox firefox-devedition-bin-unwrapped {
    #   gdkWayland = true;
    #   browserName = "firefox";
    #   nameSuffix = "-custom";
    #   name = "firefox-custom-bin-" +
    #     (builtins.parseDrvName firefox-devedition-bin-unwrapped.name).version;
    #   desktopName = "Firefox Custom";
    # })

    #firefox-wayland
    gimp
    keepass
    libreoffice-fresh
    rambox
    veracrypt
    vlc
    vscode

    # Utilities
    ntfs3g
    pciutils
    usbutils
    lm_sensors
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
    fontconfig.ultimate.enable = true;

    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
      roboto
    ];
  };

  # security.pam.enableEcryptfs = true;
  # security.wrappers.firejail.source = "${pkgs.firejail.out}/bin/firejail";
  services.printing.enable = true;
  services.flatpak.enable = true;

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

  environment.sessionVariables."MOZ_USE_XINPUT2" = "1";
}
