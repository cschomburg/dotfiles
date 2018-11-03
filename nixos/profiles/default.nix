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
    neovim
    nixUnstable
    p7zip
    patchelf
    ripgrep
    rsync
    tmux
    wget
  ];

  system.stateVersion = "unstable";
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
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIqYpmMPdFnkZjmkaOqo7DyFkOf9HPNJBK6nQnEoOSI/CWhYcVGLuHBJTXwovHetcXg/ENZ6SFJJlfoD7KeiWO/KhmTCUwHcBZHTPVQTgKOm4WiTxvcc8uFD38jnWYAn30Phy3xogEm4KMxsE+mI0A//ckq8cu24M2pGGdefpKecDBhocypOOfh8Dg2VWEHZAC+MXpwBawOw7+XP6IoRttfKHIaoh/f8ZryDAHCFRXhI6eCYGH5sULgWqviTyErc0MUVEIyYLrMqOkcTGqG3shfhuTNh1FH6oaWSctQNyAU7bdjq7bSzXkL9E1KznHXo/Jj1Cea6EyGbNz+qh9jZ3b me@cschomburg.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe2ekPNmD3OQFLX/knkGJqguRwCleqIVeY3AH3ATiTgjTxKuQhhVzOGU3vS+5+dywPj4WSmAzmjpekN+umqPUIS0ciQudsU6hnNq4eTutb1sy+EQCY/z99lmJel19TQi2WOa8drbPdrjfZy8AOiPd206gp9HoPHjVN5AaTJvU1NT4Vtt1Bc+7acJdXh6gW8WeYCNonNfxxoV6oKZkXUZHJ5vTd7NKn79CmC9N/Tqc52/r6TmnzBZowTs9xGo//HIB80zH2Qp9/Ebgon1vrpZyOLZ9C1yCYURmNDGKRuiffHi1M6wqlmNuO85atg8OmlZsJmme3LT/2IJxyr2kHKhmt6fbKk0w/cf8hQbs53KOfOEO3wtt38FLvR2hYJOLeep6q/Y3UT4TQVuLtEEgAA1wDbctJRFobOAR3Vp+FfBtN7L5GfjVu5I1CMKlPmryo7pU80HYUEr8GsIWp4NqLpjOpEjojT+tc6+hzBBVg50sAbHnjzvzo0m9WfYg21hyqcTPKIm2zbYy16MZs2d4tyJgXOhaYgXNT0LvnTdK2wNJmF7aYzNoSocoixJnRqesjVKCclJLar/cSr3N3Tf34B/zuDRgfzAMR+9D1sFZ6GGKYRgDACGuA1Kt/X0ld/7Mizf2GS0bXzsJAb/hULtE3FqlyrwiVsaYyhFvE8SN8bCJrrQ== me@cschomburg.com"
      ];
    uid = 1000;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';
}
