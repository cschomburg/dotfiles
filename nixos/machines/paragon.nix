{ config, lib, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes "];
  };

  services.nix-daemon.enable = true;

  networking.hostName = "paragon";
  networking.computerName = "paragon";

  users.users.cschomburg = {
    home = "/Users/cschomburg";
    description = "cschomburg";
  };

  nix.settings.trusted-users = [ "cschomburg" ];

  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      smb.NetBIOSName = "paragon";
      menuExtraClock.Show24Hour = true;  # show 24 hour clock

      # other macOS's defaults configuration.
      # ......
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    age
    atuin
    curlie
    devenv
    direnv
    git
    jq
    shellcheck
    starship
    tealdeer
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
      "tmux"
    ];

    casks = [
      "cryptomator"
      "dbeaver-community"
      "font-iosevka-term-nerd-font"
      "google-drive"
      "kitty"
      "obsidian"
      "rancher"
      "rectangle"
      "slack"
      "spotify"
      "syncthing"
      "visual-studio-code"

      "macos-fuse-t/homebrew-cask/fuse-t"
    ];
  };

  programs.fish.enable = true;
}
