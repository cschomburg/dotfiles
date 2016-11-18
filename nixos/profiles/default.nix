{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    binutils
    curl
    file
    git
    gnupg1
    p7zip
    patchelf
    rsync
    silver-searcher
    tmux
    vim
    wget
  ];

  nixpkgs.config.allowUnfree = true;
  programs.bash.enableCompletion = true;

  networking.firewall.allowPing = true;

  time.timeZone = "Europe/Berlin";

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  nix.trustedBinaryCaches = [ http://hydra.nixos.org/ ];
  nix.binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];

  users.extraUsers.xconstruct = {
    createHome = true;
    description = "Constantin Schomburg";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIqYpmMPdFnkZjmkaOqo7DyFkOf9HPNJBK6nQnEoOSI/CWhYcVGLuHBJTXwovHetcXg/ENZ6SFJJlfoD7KeiWO/KhmTCUwHcBZHTPVQTgKOm4WiTxvcc8uFD38jnWYAn30Phy3xogEm4KMxsE+mI0A//ckq8cu24M2pGGdefpKecDBhocypOOfh8Dg2VWEHZAC+MXpwBawOw7+XP6IoRttfKHIaoh/f8ZryDAHCFRXhI6eCYGH5sULgWqviTyErc0MUVEIyYLrMqOkcTGqG3shfhuTNh1FH6oaWSctQNyAU7bdjq7bSzXkL9E1KznHXo/Jj1Cea6EyGbNz+qh9jZ3b me@cschomburg.com" ];
    uid = 1000;
  };

  systemd.services."dotfiles-setup" = {
    description = "Setup dotfiles for xconstruct";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    script = ''
      . ${config.system.build.setEnvironment}
      dotfiles=/home/xconstruct/code/conf/dotfiles
      if [ ! -e "$dotfiles" ]; then
        ${pkgs.git}/bin/git clone https://github.com/xconstruct/dotfiles "$dotfiles"
        cd "$dotfiles"
        ./deploy
      fi
    '';
    serviceConfig = {
      User = "xconstruct";
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';
}
