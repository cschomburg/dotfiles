# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# This configuration file simply determines the hostname before importing most
# of the actual configuration from ./configuration-common.nix. This is done so
# that the same configuration files can be used with both conventionally
# installed NixOS (see nixos-install) and NixOS installed by Nixops.

{ config, pkgs, lib, ... }:

let hostName = "${builtins.readFile ./hostname}";
  unlockFile = ./private/state;
  isUnlocked = if builtins.pathExists unlockFile && (builtins.readFile unlockFile) == "unlocked"
    then true else throw "private directory is locked";
  optionalImport = file: if builtins.pathExists file && isUnlocked then [file] else [];
in
rec {
  imports =
    [
      ./hardware-configuration.nix
      ./profiles/default.nix
      (./machines + "/${hostName}.nix")
    ] ++ optionalImport (./private/machines + "/${hostName}.nix");

  networking.hostName = "${hostName}";
}
