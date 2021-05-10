{ config, pkgs, ... }:

{
  imports =
    [
    ];

  hardware.cpu.intel.updateMicrocode = true;

  environment.systemPackages = with pkgs; [
    cryptsetup
    fzf
  ];

  services.fail2ban.enable = true;

  virtualisation.libvirtd.enable = true;

  users.extraUsers.xconstruct = {
    extraGroups = [ "libvirtd" ];
  };
}
