{ config, pkgs, ... }:

{
  imports =
    [
      ../profiles/development.nix
      ../profiles/scientific.nix
    ];

    security.pam.enableEcryptfs = true;
}

