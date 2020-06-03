{ config, lib, pkgs, ... }:

{
  hardware.firmware = [ pkgs.firmwareLinuxNonfree ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.config.General = {
    FastConnectable = true;
  };
  hardware.cpu.intel.updateMicrocode = true;

  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
  '';

  #powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.cpuFreqGovernor =
    lib.mkIf config.services.tlp.enable (lib.mkForce null);
}
