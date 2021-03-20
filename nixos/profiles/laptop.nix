{ config, lib, pkgs, ... }:

{
  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  hardware.firmware = [ pkgs.firmwareLinuxNonfree ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General = {
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
  environment.sessionVariables.VDPAU_DRIVER = "va_gl";

  services.tlp.enable = true;
  services.fwupd.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
}
