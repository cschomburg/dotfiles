{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    binutils
    bashCompletion
    curl
    file
    git
    p7zip
    tmux
    vim
    wget
  ];

  nixpkgs.config.bash.enableCompletion = true;
}
