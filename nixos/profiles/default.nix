{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    archiver
    binutils
    curl
    file
    git
    gnupg1
    htop
    libarchive
    lsof
    nixFlakes
    patchelf
    ripgrep
    rsync
    tmux
    wget
    unzip
    zip

    (wrapNeovim neovim-unwrapped {
      vimAlias = true;
      viAlias = true;
    })
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enableCompletion = true;

  networking.firewall.allowPing = true;
  networking.nameservers = lib.mkDefault [
    "8.8.4.4"
    "1.1.1.1"
    "2001:4860:4860::8888"
    "2606:4700:4700::1111"
  ];

  time.timeZone = lib.mkDefault "Europe/Berlin";

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.timesyncd.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  nix.settings.trusted-substituters = [ http://hydra.nixos.org/ ];
  nix.settings.trusted-public-keys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];

  users.extraUsers.xconstruct = {
    createHome = true;
    description = "Constantin Schomburg";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAGKiClFc9OQ+5771+riM2BFzeES5z04MSXVFSmaM/Wg me+ed@cschomburg.com"
      ];
    uid = 1000;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
