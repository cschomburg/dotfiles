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
      firefox-wayland
      gimp
      insomnia
      keepassxc
      libreoffice-fresh
      noisetorch
      (pass.withExtensions (exts: [exts.pass-otp]))
      rambox
      spotify
      veracrypt
      vlc
      vscode

      # Utilities
      ntfs3g
      pciutils
      usbutils
      lm_sensors
      xclip
    ])

    (mkIf config.services.xserver.desktopManager.gnome3.enable (with pkgs.gnome3; [
      evolution
      gnome-tweaks
    ]))
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
    enableFontDir = true;
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

    fontconfig = {
      # https://github.com/stove-panini/fontconfig-emoji
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <alias binding="weak">
            <family>monospace</family>
            <prefer>
                <family>emoji</family>
            </prefer>
          </alias>

          <alias binding="weak">
            <family>sans-serif</family>
            <prefer>
                <family>emoji</family>
            </prefer>
          </alias>

          <alias binding="weak">
            <family>serif</family>
            <prefer>
                <family>emoji</family>
            </prefer>
          </alias>

          <selectfont>
            <rejectfont>
                <pattern>
                    <patelt name="family">
                        <string>DejaVu Sans</string>
                    </patelt>
                </pattern>
                <pattern>
                    <patelt name="family">
                        <string>DejaVu Serif</string>
                    </patelt>
                </pattern>
                <pattern>
                    <patelt name="family">
                        <string>DejaVu Sans Mono</string>
                    </patelt>
                </pattern>
            </rejectfont>
          </selectfont>
        </fontconfig>
      '';
    };
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
      gnome3.enable = true;
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
  environment.sessionVariables."QT_QPA_PLATFORM" = "wayland";
  environment.gnome3.excludePackages = with pkgs.gnome3; [
    geary
    gnome-calendar
    gnome-clocks
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-software
    gnome-system-monitor
    gnome-weather
    totem
    yelp
  ];

  programs.geary.enable = false;

  services.dleyna-renderer.enable = false;
  services.dleyna-server.enable = false;
  services.gnome3.gnome-online-accounts.enable = false;
  services.gnome3.tracker-miners.enable = false;
  services.gnome3.tracker.enable = false;
}
