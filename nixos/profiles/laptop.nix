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
}
