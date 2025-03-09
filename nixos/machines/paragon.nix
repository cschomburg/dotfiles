{ config, lib, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes "];
  };

  networking.hostName = "paragon";
  networking.computerName = "paragon";

  users.users.cschomburg = {
    home = "/Users/cschomburg";
    description = "cschomburg";
  };

  nix.enable = false; # managed by Determinate
  nix.settings.trusted-users = [ "cschomburg" ];
  nixpkgs.config.allowUnfree = true;

  ids.gids.nixbld = 30000; # https://github.com/LnL7/nix-darwin/issues/1339

  system = {
    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      smb.NetBIOSName = "paragon";
      menuExtraClock.Show24Hour = true;  # show 24 hour clock


      dock = {
        autohide = true;
        show-recents = false; # disable recent apps

        # customize hot corners
        wvous-tl-corner = 2; # top-left - mission control
      };

      finder = {
        _FXShowPosixPathInTitle = true;  # show full path in finder title
        AppleShowAllExtensions = true;  # show all file extensions
        FXEnableExtensionChangeWarning = false;  # disable warning when changing file extension
        QuitMenuItem = true;  # enable quit menu item
        ShowPathbar = true;  # show path bar
        ShowStatusBar = true;  # show status bar
      };

      trackpad = {
        Clicking = true;  # enable tap to click
        TrackpadRightClick = true;  # enable two finger right click
      };

      # customize settings that not supported by nix-darwin directly
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        InitialKeyRepeat = 15;  # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        KeyRepeat = 3;  # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)
      };
    };

    keyboard = {
      remapCapsLockToEscape = true; # remap caps lock to escape, useful for vim users
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = with pkgs; [
    aider-chat
    age
    atuin
    bun
    claude-code
    curlie
    deluge-gtk
    devenv
    direnv
    eslint
    git
    git-crypt
    git-annex
    git-remote-gcrypt
    gmailctl
    intelephense
    jq
    kubie
    nodejs
    shellcheck
    starship
    tealdeer
    terraform-ls
    tmux
    typescript-language-server
    vue-language-server
    zoxide
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
      "gnupg"
      "pinentry-mac"
    ];

    casks = [
      "calibre"
      "chatgpt"
      "cryptomator"
      "dbeaver-community"
      "font-iosevka-term-nerd-font"
      "ghostty"
      "google-drive"
      "iina"
      "kitty"
      "obsidian"
      "rancher"
      "raycast"
      "shottr"
      "slack"
      "spotify"
      "syncthing"
      "tunnelblick"
      "visual-studio-code"

      "macos-fuse-t/homebrew-cask/fuse-t"
    ];
  };

  programs.fish.enable = true;
}
