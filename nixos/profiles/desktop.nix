{ config, lib, pkgs, ... }:

with lib;

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  boot.tmp.cleanOnBoot = true;
  networking.networkmanager = {
    enable = true;
    dns = "none";
  };

  environment.systemPackages = mkMerge [
    (with pkgs; [
      aichat
      alacritty
      calibre
      cryptomator
      google-chrome
      deluge-2_x
      firefox-wayland
      gimp
      gmailctl
      gnome3.gnome-boxes
      gthumb
      insomnia
      keepassxc
      kitty
      libreoffice-fresh
      (pass.withExtensions (exts: [exts.pass-otp]))
      rambox
      spotify
      veracrypt
      virt-manager
      vlc
      vscode

      # Utilities
      ntfs3g
      pciutils
      usbutils
      lm_sensors
      xclip
      wl-clipboard

      # Gnome extensions
      gnomeExtensions.gsconnect
    ])

    (mkIf config.services.xserver.desktopManager.gnome.enable (with pkgs; [
      gnome-tweaks
    ]))
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [
      caladea
      carlito
      corefonts
      inconsolata
      iosevka
      liberation_ttf_v2
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      roboto
      ttf_bitstream_vera
    ];
  };

  # security.pam.enableEcryptfs = true;
  # security.wrappers.firejail.source = "${pkgs.firejail.out}/bin/firejail";
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ gutenprint ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.flatpak.enable = true;

  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "altgr-intl";
    xkb.options = "eurosign:e";

    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
      #sddm.enable = true;

      # extraSessionFilePackages = with pkgs; [ plasma5.plasma-workspace ];
    };

    desktopManager = {
      gnome.enable = true;
      #plasma5.enable = true;
    };
  };

  services.libinput = {
    enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.sessionVariables."MOZ_USE_XINPUT2" = "1";
  #environment.sessionVariables."QT_QPA_PLATFORM" = "wayland";
  environment.gnome.excludePackages = with pkgs; [
    geary
    gnome-calendar
    gnome-connections
    gnome-photos
    gnome-system-monitor
    totem
    yelp

    gnome.gnome-clocks
    gnome.gnome-contacts
    gnome.gnome-logs
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-software
    gnome.gnome-weather
  ];

  programs.evolution.enable = true;
  programs.geary.enable = false;

  services.dleyna-renderer.enable = false;
  services.dleyna-server.enable = false;
  services.gnome.gnome-online-accounts.enable = false;
  services.gnome.tracker-miners.enable = false;
  services.gnome.tracker.enable = false;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };
}
