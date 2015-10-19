{ config, lib, pkgs, ... }:

with lib;
rec {
  imports = [
    ./profiles/default.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  users.extraUsers.xconstruct = {
    createHome = true;
    description = "Constantin Schomburg";
    extraGroups = [ "wheel" "networkmanager" "vboxusers"];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIqYpmMPdFnkZjmkaOqo7DyFkOf9HPNJBK6nQnEoOSI/CWhYcVGLuHBJTXwovHetcXg/ENZ6SFJJlfoD7KeiWO/KhmTCUwHcBZHTPVQTgKOm4WiTxvcc8uFD38jnWYAn30Phy3xogEm4KMxsE+mI0A//ckq8cu24M2pGGdefpKecDBhocypOOfh8Dg2VWEHZAC+MXpwBawOw7+XP6IoRttfKHIaoh/f8ZryDAHCFRXhI6eCYGH5sULgWqviTyErc0MUVEIyYLrMqOkcTGqG3shfhuTNh1FH6oaWSctQNyAU7bdjq7bSzXkL9E1KznHXo/Jj1Cea6EyGbNz+qh9jZ3b me@cschomburg.com" ];
    uid = 1000;
  };

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
}
