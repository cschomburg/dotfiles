{ config, lib, pkgs, ... }:

with lib;

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

  environment.systemPackages = mkMerge [
    (with pkgs; [
      alacritty
      calibre
      google-chrome-beta
      deluge-2_x
      ferdi
      firefox-wayland
      gimp
      gthumb
      insomnia
      kdeconnect
      keepassxc
      kitty
      libreoffice-fresh
      neuron-notes
      noisetorch
      (pass.withExtensions (exts: [exts.pass-otp]))
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
    ])

    (mkIf config.services.xserver.desktopManager.gnome.enable (with pkgs.gnome3; [
      gnome-tweaks
    ]))
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      caladea
      carlito
      corefonts
      inconsolata
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
  services.avahi.nssmdns = true;
  services.flatpak.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "eurosign:e";

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

  services.xserver.libinput = {
    enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.sessionVariables."MOZ_USE_XINPUT2" = "1";
  #environment.sessionVariables."QT_QPA_PLATFORM" = "wayland";
  environment.gnome.excludePackages = with pkgs.gnome3; [
    geary
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    pkgs.gnome-photos
    gnome-software
    gnome-system-monitor
    gnome-weather
    pkgs.gnome-connections
    totem
    yelp
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
