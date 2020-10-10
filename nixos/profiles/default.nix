{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
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
    neovim
    nixUnstable
    patchelf
    ripgrep
    rsync
    tmux
    wget
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enableCompletion = true;

  networking.firewall.allowPing = true;
  networking.nameservers = [
    "8.8.4.4"
    "1.1.1.1"
    "2001:4860:4860::8888"
    "2606:4700:4700::1111"
  ];

  time.timeZone = "Europe/Berlin";

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.timesyncd.enable = true;
  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 9993 ];

  nix.trustedBinaryCaches = [ http://hydra.nixos.org/ ];
  nix.binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];

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
}
