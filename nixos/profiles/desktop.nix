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
    kdeconnect
    keepass
    libreoffice-fresh
    rambox
    veracrypt
    vlc
    vscodium

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
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      caladea
      carlito
      corefonts
      inconsolata
      liberation_ttf_v2
      noto-fonts
      noto-fonts-emoji
      roboto
      ttf_bitstream_vera
    ];

    fontconfig = {
      penultimate.enable = false;

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

      extraSessionFilePackages = with pkgs; [ plasma5.plasma-workspace ];
    };

    desktopManager = {
      gnome3.enable = true;
      plasma5.enable = true;
    };
  };

  services.xserver.libinput = {
    enable = true;
  };

  environment.sessionVariables."MOZ_USE_XINPUT2" = "1";
}
