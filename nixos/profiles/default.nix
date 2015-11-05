{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    binutils
    curl
    file
    git
    gnupg
    p7zip
    patchelf
    silver-searcher
    tmux
    vim
    wget
  ];

  programs.bash.enableCompletion = true;
}
